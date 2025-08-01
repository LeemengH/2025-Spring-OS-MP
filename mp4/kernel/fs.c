// File system implementation.  Five layers:
//   + Blocks: allocator for raw disk blocks.
//   + Log: crash recovery for multi-step updates.
//   + Files: inode allocator, reading, writing, metadata.
//   + Directories: inode with special contents (list of other inodes!)
//   + Names: paths like /usr/rtm/xv6/fs.c for convenient naming.
//
// This file contains the low-level file system manipulation
// routines.  The (higher-level) system call implementations
// are in sysfile.c.

#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "stat.h"
#include "spinlock.h"
#include "proc.h"
#include "sleeplock.h"
#include "fs.h"
#include "buf.h"
#include "file.h"

#define min(a, b) ((a) < (b) ? (a) : (b))
// there should be one superblock per disk device, but we run with
// only one device
struct superblock sb;

// Read the super block.
static void readsb(int dev, struct superblock *sb)
{
    struct buf *bp;

    bp = bread(dev, 1);
    memmove(sb, bp->data, sizeof(*sb));
    brelse(bp);
}

// Init fs
void fsinit(int dev)
{
    readsb(dev, &sb);
    if (sb.magic != FSMAGIC)
        panic("invalid file system");
    initlog(dev, &sb);
}

// Zero a block.
static void bzero(int dev, int bno)
{
    struct buf *bp;

    bp = bread(dev, bno);
    memset(bp->data, 0, BSIZE);
    log_write(bp);
    brelse(bp);
}

// Blocks.

// Allocate a zeroed disk block.
static uint balloc(uint dev)
{
    int b, bi, m;
    struct buf *bp;

    bp = 0;
    for (b = 0; b < sb.size; b += BPB)
    {
        bp = bread(dev, BBLOCK(b, sb));
        for (bi = 0; bi < BPB && b + bi < sb.size; bi++)
        {
            m = 1 << (bi % 8);
            if ((bp->data[bi / 8] & m) == 0)
            {                          // Is block free?
                bp->data[bi / 8] |= m; // Mark block in use.
                log_write(bp);
                brelse(bp);
                bzero(dev, b + bi);
                return b + bi;
            }
        }
        brelse(bp);
    }
    panic("balloc: out of blocks");
}

// Free a disk block.
static void bfree(int dev, uint b)
{
    struct buf *bp;
    int bi, m;

    bp = bread(dev, BBLOCK(b, sb));
    bi = b % BPB;
    m = 1 << (bi % 8);
    if ((bp->data[bi / 8] & m) == 0)
        panic("freeing free block");
    bp->data[bi / 8] &= ~m;
    log_write(bp);
    brelse(bp);
}

// Inodes.
//
// An inode describes a single unnamed file.
// The inode disk structure holds metadata: the file's type,
// its size, the number of links referring to it, and the
// list of blocks holding the file's content.
//
// The inodes are laid out sequentially on disk at
// sb.startinode. Each inode has a number, indicating its
// position on the disk.
//
// The kernel keeps a cache of in-use inodes in memory
// to provide a place for synchronizing access
// to inodes used by multiple processes. The cached
// inodes include book-keeping information that is
// not stored on disk: ip->ref and ip->valid.
//
// An inode and its in-memory representation go through a
// sequence of states before they can be used by the
// rest of the file system code.
//
// * Allocation: an inode is allocated if its type (on disk)
//   is non-zero. ialloc() allocates, and iput() frees if
//   the reference and link counts have fallen to zero.
//
// * Referencing in cache: an entry in the inode cache
//   is free if ip->ref is zero. Otherwise ip->ref tracks
//   the number of in-memory pointers to the entry (open
//   files and current directories). iget() finds or
//   creates a cache entry and increments its ref; iput()
//   decrements ref.
//
// * Valid: the information (type, size, &c) in an inode
//   cache entry is only correct when ip->valid is 1.
//   ilock() reads the inode from
//   the disk and sets ip->valid, while iput() clears
//   ip->valid if ip->ref has fallen to zero.
//
// * Locked: file system code may only examine and modify
//   the information in an inode and its content if it
//   has first locked the inode.
//
// Thus a typical sequence is:
//   ip = iget(dev, inum)
//   ilock(ip)
//   ... examine and modify ip->xxx ...
//   iunlock(ip)
//   iput(ip)
//
// ilock() is separate from iget() so that system calls can
// get a long-term reference to an inode (as for an open file)
// and only lock it for short periods (e.g., in read()).
// The separation also helps avoid deadlock and races during
// pathname lookup. iget() increments ip->ref so that the inode
// stays cached and pointers to it remain valid.
//
// Many internal file system functions expect the caller to
// have locked the inodes involved; this lets callers create
// multi-step atomic operations.
//
// The icache.lock spin-lock protects the allocation of icache
// entries. Since ip->ref indicates whether an entry is free,
// and ip->dev and ip->inum indicate which i-node an entry
// holds, one must hold icache.lock while using any of those fields.
//
// An ip->lock sleep-lock protects all ip-> fields other than ref,
// dev, and inum.  One must hold ip->lock in order to
// read or write that inode's ip->valid, ip->size, ip->type, &c.

struct
{
    struct spinlock lock;
    struct inode inode[NINODE];
} icache;

void iinit()
{
    int i = 0;

    initlock(&icache.lock, "icache");
    for (i = 0; i < NINODE; i++)
    {
        initsleeplock(&icache.inode[i].lock, "inode");
    }
}

struct inode *iget(uint dev, uint inum);

/* TODO: Access Control & Symbolic Link */
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode *ialloc(uint dev, short type)
{
    int inum;
    struct buf *bp;
    struct dinode *dip;

    for (inum = 1; inum < sb.ninodes; inum++)
    {
        bp = bread(dev, IBLOCK(inum, sb));
        dip = (struct dinode *)bp->data + inum % IPB;
        if (dip->type == 0)
        { // a free inode
            memset(dip, 0, sizeof(*dip));
            dip->type = type;
            dip->mode = M_ALL;
            log_write(bp); // mark it allocated on the disk
            brelse(bp);
            return iget(dev, inum);
        }
        brelse(bp);
    }
    panic("ialloc: no inodes");
}

/* TODO: Access Control & Symbolic Link */
// Copy a modified in-memory inode to disk.
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void iupdate(struct inode *ip)
{
    struct buf *bp;
    struct dinode *dip;

    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode *)bp->data + ip->inum % IPB;
    dip->type = ip->type;
    dip->major = ip->major;
    // dip->minor = ip->minor;
    dip->nlink = ip->nlink;
    dip->size = ip->size;
    dip->mode = ip->mode; // <-- Add this line
    memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    log_write(bp);
    brelse(bp);
}

// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
struct inode *iget(uint dev, uint inum)
{
    struct inode *ip, *empty;

    acquire(&icache.lock);

    // Is the inode already cached?
    empty = 0;
    for (ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++)
    {
        if (ip->ref > 0 && ip->dev == dev && ip->inum == inum)
        {
            ip->ref++;
            release(&icache.lock);
            return ip;
        }
        if (empty == 0 && ip->ref == 0) // Remember empty slot.
            empty = ip;
    }

    // Recycle an inode cache entry.
    if (empty == 0)
        panic("iget: no inodes");

    ip = empty;
    ip->dev = dev;
    ip->inum = inum;
    ip->ref = 1;
    ip->valid = 0;
    release(&icache.lock);

    return ip;
}

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode *idup(struct inode *ip)
{
    acquire(&icache.lock);
    ip->ref++;
    release(&icache.lock);
    return ip;
}

/* TODO: Access Control & Symbolic Link */
// Lock the given inode.
// Reads the inode from disk if necessary.
void ilock(struct inode *ip)
{
    struct buf *bp;
    struct dinode *dip;

    if (ip == 0 || ip->ref < 1)
        panic("ilock");

    acquiresleep(&ip->lock);

    if (ip->valid == 0)
    {
        bp = bread(ip->dev, IBLOCK(ip->inum, sb));
        dip = (struct dinode *)bp->data + ip->inum % IPB;
        ip->type = dip->type;
        ip->major = dip->major;
        // ip->minor = dip->minor;
        ip->nlink = dip->nlink;
        ip->size = dip->size;
        ip->mode = dip->mode; // <-- Add this line
        memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
        brelse(bp);
        ip->valid = 1;
        if (ip->type == 0)
            panic("ilock: no type");
    }
}

// Unlock the given inode.
void iunlock(struct inode *ip)
{
    if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
        panic("iunlock");

    releasesleep(&ip->lock);
}

// Drop a reference to an in-memory inode.
// If that was the last reference, the inode cache entry can
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void iput(struct inode *ip)
{
    acquire(&icache.lock);

    if (ip->ref == 1 && ip->valid && ip->nlink == 0)
    {
        // inode has no links and no other references: truncate and free.

        // ip->ref == 1 means no other process can have ip locked,
        // so this acquiresleep() won't block (or deadlock).
        acquiresleep(&ip->lock);

        release(&icache.lock);

        itrunc(ip);
        ip->type = 0;
        iupdate(ip);
        ip->valid = 0;

        releasesleep(&ip->lock);

        acquire(&icache.lock);
    }

    ip->ref--;
    release(&icache.lock);
}

// Common idiom: unlock, then put.
void iunlockput(struct inode *ip)
{
    iunlock(ip);
    iput(ip);
}

// Inode content
//
// The content (data) associated with each inode is stored
// in blocks on the disk. The first NDIRECT block numbers
// are listed in ip->addrs[].  The next NINDIRECT blocks are
// listed in block ip->addrs[NDIRECT].

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.

uint bmap(struct inode *ip, uint bn)
{
    uint addr, *a;
    struct buf *bp;

    if (bn < NDIRECT) //
    {
        if ((addr = ip->addrs[bn]) == 0)
        {
            addr = balloc(ip->dev);
            if (addr == 0)
                panic("bmap: balloc failed");
            ip->addrs[bn] = addr;
        }
        return addr;
    }
    bn -= NDIRECT;
    if (bn < NINDIRECT)
    {
        if ((addr = ip->addrs[NDIRECT]) == 0)
        {
            addr = balloc(ip->dev);
            if (addr == 0)
                panic("bmap: balloc failed for indirect block");
            ip->addrs[NDIRECT] = addr;
        }

        bp = bread(ip->dev, addr);
        a = (uint *)bp->data;

        uint target_addr = a[bn];

        if (target_addr == 0)
        {
            target_addr = balloc(ip->dev);
            if (target_addr == 0)
                panic("bmap: balloc failed for data block via indirect");
            a[bn] = target_addr;
            log_write(bp);
        }
        brelse(bp);

        return target_addr;
    }

    printf("bmap: ERROR! file_bn %d is out of range for inode %d\n",
           bn + NDIRECT, ip->inum);
    panic("bmap: out of range");
}

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void itrunc(struct inode *ip)
{
    int i, j;
    struct buf *bp;
    uint *a;

    for (i = 0; i < NDIRECT; i++)
    {
        if (ip->addrs[i])
        {
            bfree(ip->dev, ip->addrs[i]);
            ip->addrs[i] = 0;
        }
    }

    if (ip->addrs[NDIRECT])
    {
        bp = bread(ip->dev, ip->addrs[NDIRECT]);
        a = (uint *)bp->data;
        for (j = 0; j < NINDIRECT; j++)
        {
            if (a[j])
                bfree(ip->dev, a[j]);
        }
        brelse(bp);
        bfree(ip->dev, ip->addrs[NDIRECT]);
        ip->addrs[NDIRECT] = 0;
    }

    ip->size = 0;
    iupdate(ip);
}

/* TODO: Access Control & Symbolic Link */
// Copy stat information from inode.
// Caller must hold ip->lock.
void stati(struct inode *ip, struct stat *st)
{
    st->dev = ip->dev;
    st->ino = ip->inum;
    st->type = ip->type;
    st->nlink = ip->nlink;
    st->size = ip->size;
    st->mode = ip->mode;  // <-- Add this line
}

// Read data from inode.
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.
int readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    uint tot, m;
    struct buf *bp;

    if (off > ip->size || off + n < off)
        return 0;
    if (off + n > ip->size)
        n = ip->size - off;

    for (tot = 0; tot < n; tot += m, off += m, dst += m)
    {
        bp = bread(ip->dev, bmap(ip, off / BSIZE));
        m = min(n - tot, BSIZE - off % BSIZE);
        if (either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1)
        {
            brelse(bp);
            break;
        }
        brelse(bp);
    }
    return tot;
}

// Write data to inode.
// Caller must hold ip->lock.
// If user_src==1, then src is a user virtual address;
// otherwise, src is a kernel address.
int writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    uint tot, m;
    struct buf *bp;

    if (off > ip->size || off + n < off)
        return -1;
    if (off + n > MAXFILE * BSIZE)
        return -1;

    for (tot = 0; tot < n; tot += m, off += m, src += m)
    {
        uint bn = off / BSIZE;
        uint disk_lbn = bmap(ip, bn);
        bp = bread(ip->dev, disk_lbn);
        m = min(n - tot, BSIZE - off % BSIZE);
        if (either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1)
        {
            brelse(bp);
            break;
        }
        log_write(bp);
        brelse(bp);
    }

    if (n > 0)
    {
        if (off > ip->size)
            ip->size = off;
        // write the i-node back to disk even if the size didn't change
        // because the loop above might have called bmap() and added a new
        // block to ip->addrs[].
        iupdate(ip);
    }

    return n;
}

// Directories

int namecmp(const char *s, const char *t) { return strncmp(s, t, DIRSIZ); }

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode *dirlookup(struct inode *dp, char *name, uint *poff)
{
    uint off, inum;
    struct dirent de;

    if (dp->type != T_DIR)
        panic("dirlookup not DIR");

    for (off = 0; off < dp->size; off += sizeof(de))
    {
        if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
            panic("dirlookup read");
        if (de.inum == 0)
            continue;
        // printf("[dirlookup] de.name = %s, name = %s, cmp = %d\n", de.name, name, namecmp(name, de.name));
        // printf("de.name = {");
        // for (int i = 0; i < strlen(de.name); i++)
        //     printf("%d ", de.name[i]);
        // printf("}\n");
        // printf("name = {");
        // for (int i = 0; i < strlen(name); i++)
        //     printf("%d ", name[i]);
        // printf("}\n");
        if (namecmp(name, de.name) == 0)
        {
            // printf("@@Match!@@\n");
            // entry matches path element
            if (poff)
                *poff = off;
            inum = de.inum;
            return iget(dp->dev, inum);
        }
    }

    return 0;
}

// Write a new directory entry (name, inum) into the directory dp.
int dirlink(struct inode *dp, char *name, uint inum)
{
    int off;
    struct dirent de;
    struct inode *ip;

    // Check that name is not present.
    if ((ip = dirlookup(dp, name, 0)) != 0)
    {
        iput(ip);
        return -1;
    }

    // Look for an empty dirent.
    for (off = 0; off < dp->size; off += sizeof(de))
    {
        if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
            panic("dirlink read");
        if (de.inum == 0)
            break;
    }

    strncpy(de.name, name, DIRSIZ);
    de.inum = inum;
    if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
        panic("dirlink");

    return 0;
}

// Paths

// Copy the next path element from path into name.
// Return a pointer to the element following the copied one.
// The returned path has no leading slashes,
// so the caller can check *path=='\0' to see if the name is the last one.
// If no name to remove, return 0.
//
// Examples:
//   skipelem("a/bb/c", name) = "bb/c", setting name = "a"
//   skipelem("///a//bb", name) = "bb", setting name = "a"
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char *skipelem(char *path, char *name)
{
    char *s;
    int len;

    while (*path == '/')
        path++;
    if (*path == 0)
        return 0;
    s = path;
    while (*path != '/' && *path != 0)
        path++;
    len = path - s;
    if (len >= DIRSIZ)
        memmove(name, s, DIRSIZ);
    else
    {
        memmove(name, s, len);
        name[len] = 0;
    }
    while (*path == '/')
        path++;
    return path;
}

// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
// struct inode *namex(char *path, int nameiparent, char *name)
// {
//     struct inode *ip, *next;

//     if (*path == '/')
//         ip = iget(ROOTDEV, ROOTINO);
//     else
//         ip = idup(myproc()->cwd);

//     while ((path = skipelem(path, name)) != 0)
//     {
//         ilock(ip);
//         if (ip->type != T_DIR)
//         {
//             iunlockput(ip);
//             return 0;
//         }

//         //+++++++++++++++++++
//         // Check: does this directory have read permission?
//         if ((ip->mode & M_READ) == 0)
//         {
//             iunlockput(ip);
//             return 0;  // deny traversal
//         }
//         //+++++++++++++++++++
        
//         if (nameiparent && *path == '\0')
//         {
//             // Stop one level early.
//             iunlock(ip);
//             return ip;
//         }
//         if ((next = dirlookup(ip, name, 0)) == 0)
//         {
//             iunlockput(ip);
//             return 0;
//         }
//         iunlockput(ip);
//         ip = next;
//     }
//     if (nameiparent)
//     {
//         iput(ip);
//         return 0;
//     }
//     return ip;
// }
// Append src to dest. Make sure not to overflow max.
// Returns dest.
char * safestrcat(char *dest, const char *src, int max)
{
    int i = 0;

    // Find end of dest
    while (i < max && dest[i] != '\0')
        i++;

    int j = 0;
    while (i < max - 1 && src[j] != '\0') {
        dest[i++] = src[j++];
    }

    dest[i] = '\0';  // Ensure null-termination

    return dest;
}

char *concat_path(char *target, char *rest) {
    static char buf[128];
    safestrcpy(buf, target, sizeof(buf));
    if (*rest) {
        safestrcat(buf, "/", 128);
        safestrcat(buf, rest, 128);
    }
    return buf;
}

#define MAX_SYMLINK_DEPTH 10

struct inode *namex(char *path, int nameiparent, char *name, int follow)
{
    struct inode *ip, *next;
    int symlink_depth = 0;

    if (*path == '/'){
        ip = iget(ROOTDEV, ROOTINO);
    }
    else
        ip = idup(myproc()->cwd);

    while ((path = skipelem(path, name)) != 0)
    {
        ilock(ip);
        if (ip->type != T_DIR)
        {
            // printf("fs <0>\n");
            iunlockput(ip);
            return 0;
        }

        // Permission check
        if ((ip->mode & M_READ) == 0)
        {
            // printf("fs <1>\n");
            iunlockput(ip);
            return 0;
        }

        // Check for parent request
        if (nameiparent && *path == '\0')
        {
            // printf("fs <2>\n");
            iunlock(ip);
            return ip;
        }
        // printf("<fs> Count!\n");
        // printf("fs <3>, name = %s, path = %s, ip address = %d\n", name, path, ip->addrs);
        if ((next = dirlookup(ip, name, 0)) == 0)
        {
            // printf("fs <3> fail..\n");
            iunlockput(ip);
            return 0;
        }
        // printf("=================\n");
        iunlockput(ip);
        ip = next;
        // Determine if this is the last path element
        int is_last = (*path == '\0');
        // if (follow){
        //     ilock(next);
        //     printf("path = %s, name = %s, next_type = %d, is_last = %d\n", path, name, next->type, is_last);
        //     iunlock(next);
        // }
        if (follow){
            ilock(next);
            // Handle symlink resolution if needed
            // printf("path = %s, name = %s, next_type = %d, is_last = %d\n", path, name, next->type, is_last);
            if (next->type == T_SYMLINK && (!is_last))
            {
                if (++symlink_depth > MAX_SYMLINK_DEPTH)
                {
                    //printf("!!!!!!!!!!3\n");
                    iunlockput(next);
                    return 0;  // too many symlinks
                }
                // Read the symlink target
                char target[DIRSIZ + 1] = {0}; // Ensure null-terminated
                readi(next, 0, (uint64)target, 0, DIRSIZ);
                // target[DIRSIZ - 1] = '\0'; // null-terminate
                iunlockput(next);
                
                path = concat_path(target, path);
                // printf("<fs> path = %s, target = %s\n", path, target);
                
                // iput(ip);
                
                return namex(path, nameiparent, name, follow);
                // // Restart resolution from the symlink target
                // if (*target == '/'){
                //     // printf("!!!!!!!!!!\n");
                //     ip = iget(ROOTDEV, ROOTINO);
                // }
                // else{
                //     ilock(ip);
                //     ip = idup(ip);  // start from current dir
                //     iunlock(ip);
                // }
                // path = concat_path(target, path); // Combine symlink target + remaining path
                // // Restart outer while loop with new path
                // // printf("path = %s\n", path);
                // // printf("target = %s\n", target);
                // break;
            }
            else iunlock(next);
        }
        // ip = next;
    }

    if (nameiparent)
    {
        iput(ip);
        return 0;
    }

    return ip;
}

struct inode *namei(char *path)
{
    char name[DIRSIZ];
    return namex(path, 0, name, 0);
}

struct inode *namei_follow(char *path)
{
    char name[DIRSIZ];

    return namex(path, 0, name, 1);
}

struct inode *nameiparent(char *path, char *name)
{
    return namex(path, 1, name, 0);
}

struct inode* follow_symlink(struct inode *ip, int depth, int read) {
    if (depth > 10) {
        iunlockput(ip);
        return 0; // prevent infinite loop
    }

    if (ip->type != T_SYMLINK) {
        return ip; // not a symlink
    }

    char target[MAXPATH] = {0};

    int len = readi(ip, 0, (uint64)target, 0, MAXPATH);
    iunlockput(ip); // Done with current symlink

    if (len <= 0) {
        return 0;
    }

    // printf("==========");
    // printf(target);  
    // printf("==========\n");

    struct inode *next = namei(target);
    if (!next) return 0;

    ilock(next);

    if (next->type == T_SYMLINK) {
        if (read) {
            return follow_symlink(next, depth + 1, 1);
        } else return follow_symlink(next, depth + 1, 0);
    }

    // It's a regular file or directory — OK to return
    // printf("Type of file stored in symln = %d\n", next->type);
    if (read){
        iunlockput(next);
        // ilock(ip);
        return ip;
    }else return next;
}