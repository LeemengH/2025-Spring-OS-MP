//
// File-system system calls.
// Mostly argument checking, since we don't trust
// user code, and calls into file.c and fs.c.
//

#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "stat.h"
#include "spinlock.h"
#include "proc.h"
#include "fs.h"
#include "sleeplock.h"
#include "file.h"
#include "fcntl.h"
#include "buf.h"


// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int argfd(int n, int *pfd, struct file **pf)
{
    int fd;
    struct file *f;

    if (argint(n, &fd) < 0)
        return -1;
    if (fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == 0)
        return -1;
    if (pfd)
        *pfd = fd;
    if (pf)
        *pf = f;
    return 0;
}

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int fdalloc(struct file *f)
{
    int fd;
    struct proc *p = myproc();

    for (fd = 0; fd < NOFILE; fd++)
    {
        if (p->ofile[fd] == 0)
        {
            p->ofile[fd] = f;
            return fd;
        }
    }
    return -1;
}

uint64 sys_dup(void)
{
    struct file *f;
    int fd;

    if (argfd(0, 0, &f) < 0)
        return -1;
    if ((fd = fdalloc(f)) < 0)
        return -1;
    filedup(f);
    return fd;
}

uint64 sys_read(void)
{
    struct file *f;
    int n;
    uint64 p;

    if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
        return -1;
    return fileread(f, p, n);
}

uint64 sys_write(void)
{
    struct file *f;
    int n;
    uint64 p;

    if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
        return -1;

    return filewrite(f, p, n);
}

uint64 sys_close(void)
{
    int fd;
    struct file *f;

    if (argfd(0, &fd, &f) < 0)
        return -1;
    myproc()->ofile[fd] = 0;
    fileclose(f);
    return 0;
}

uint64 sys_fstat(void)
{
    struct file *f;
    uint64 st; // user pointer to struct stat

    if (argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
        return -1;
    return filestat(f, st);
}

// Create the path new as a link to the same inode as old.
uint64 sys_link(void)
{
    char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
    struct inode *dp, *ip;

    if (argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
        return -1;

    begin_op();
    if ((ip = namei(old)) == 0)
    {
        end_op();
        return -1;
    }

    ilock(ip);
    if (ip->type == T_DIR)
    {
        iunlockput(ip);
        end_op();
        return -1;
    }

    ip->nlink++;
    iupdate(ip);
    iunlock(ip);

    if ((dp = nameiparent(new, name)) == 0)
        goto bad;
    ilock(dp);
    if (dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
    {
        iunlockput(dp);
        goto bad;
    }
    iunlockput(dp);
    iput(ip);

    end_op();

    return 0;

bad:
    ilock(ip);
    ip->nlink--;
    iupdate(ip);
    iunlockput(ip);
    end_op();
    return -1;
}

// Is the directory dp empty except for "." and ".." ?
static int isdirempty(struct inode *dp)
{
    int off;
    struct dirent de;

    for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de))
    {
        if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
            panic("isdirempty: readi");
        if (de.inum != 0)
            return 0;
    }
    return 1;
}

uint64 sys_unlink(void)
{
    struct inode *ip, *dp;
    struct dirent de;
    char name[DIRSIZ], path[MAXPATH];
    uint off;

    if (argstr(0, path, MAXPATH) < 0)
        return -1;

    begin_op();
    if ((dp = nameiparent(path, name)) == 0)
    {
        end_op();
        return -1;
    }

    ilock(dp);

    // Cannot unlink "." or "..".
    if (namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
        goto bad;

    if ((ip = dirlookup(dp, name, &off)) == 0)
        goto bad;
    ilock(ip);

    if (ip->nlink < 1)
        panic("unlink: nlink < 1");
    if (ip->type == T_DIR && !isdirempty(ip))
    {
        iunlockput(ip);
        goto bad;
    }

    memset(&de, 0, sizeof(de));
    if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
        panic("unlink: writei");
    if (ip->type == T_DIR)
    {
        dp->nlink--;
        iupdate(dp);
    }
    iunlockput(dp);

    ip->nlink--;
    iupdate(ip);
    iunlockput(ip);

    end_op();

    return 0;

bad:
    iunlockput(dp);
    end_op();
    return -1;
}

// static struct inode *create(char *path, short type, short major, short minor)
static struct inode *create(char *path, short type, short major)
{
    struct inode *ip, *dp;
    char name[DIRSIZ];

    if ((dp = nameiparent(path, name)) == 0)
        return 0;

    ilock(dp);

    if ((ip = dirlookup(dp, name, 0)) != 0)
    {
        iunlockput(dp);
        ilock(ip);
        if (type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
            return ip;
        iunlockput(ip);
        return 0;
    }

    if ((ip = ialloc(dp->dev, type)) == 0)
        panic("create: ialloc");

    ilock(ip);
    ip->major = major;
    // ip->minor = minor;
    ip->nlink = 1;
    ip->mode = M_ALL;
    iupdate(ip);

    if (type == T_DIR)
    {                // Create . and .. entries.
        dp->nlink++; // for ".."
        iupdate(dp);
        // No ip->nlink++ for ".": avoid cyclic ref count.
        if (dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
            panic("create dots");
    }

    if (dirlink(dp, name, ip->inum) < 0)
        panic("create: dirlink");

    iunlockput(dp);

    return ip;
}

/* TODO: Access Control & Symbolic Link */
uint64 sys_open(void)
{
    char path[MAXPATH];
    int fd, omode;
    struct file *f;
    struct inode *ip;
    int n;

    if ((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
        return -1;

    begin_op();

    if (omode & O_CREATE)
    {
        // ip = create(path, T_FILE, 0, 0);
        ip = create(path, T_FILE, 0);
        if (ip == 0)
        {
            end_op();
            return -1;
        }
    }
    else
    {
        // printf("====== 1 =======\n");
        if ((ip = namei_follow(path)) == 0)
        {
            // printf("sys <1>\n");
            end_op();
            return -1;
        }
        ilock(ip);
        // printf(" type in sys_open  = %d\n", ip->type);
        // ++++++++++++++++++
        // Follow symlink unless O_NOACCESS is set
        if (ip->type == T_SYMLINK && !(omode & O_NOACCESS)) {
            ip = follow_symlink(ip, 0, 0);  // depth = 0
            if (ip == 0) {
                // printf("sys <2>\n");
                end_op();
                return -1;
            }
        }
        // ++++++++++++++++++
        // printf("====== 2 =======\n");
        // printf("sys <3>\n");
        if (ip->type == T_DIR && (omode != O_RDONLY && omode != O_NOACCESS))
        {
            iunlockput(ip);
            end_op();
            return -1;
        }
        //++++++++++++++++++
        // Check permissions
        if (!(omode & O_NOACCESS))  // Only check for actual read/write
        {
            int mode = ip->mode;
            if ((omode & O_WRONLY || omode & O_RDWR) && !(mode & M_WRITE)) {
                iunlockput(ip);
                end_op();
                return -1;
            }

            if ((omode == O_RDONLY || omode & O_RDWR) && !(mode & M_READ)) {
                iunlockput(ip);
                end_op();
                return -1;
            }
        }
        //++++++++++++++++++
    }

    if (ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV))
    {
        iunlockput(ip);
        end_op();
        return -1;
    }

    // printf("====== 3 =======\n");
    if ((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0)
    {
        if (f)
            fileclose(f);
        iunlockput(ip);
        end_op();
        return -1;
    }

    // Init file struct
    if (ip->type == T_DEVICE)
    {
        f->type = FD_DEVICE;
        f->major = ip->major;
    }
    else
    {
        f->type = FD_INODE;
        f->off = 0;
    }
    f->ip = ip;

    // ++++++++++++++++++
    // O_NOACCESS overrides other flags
    if (omode & O_NOACCESS)
    {
        f->readable = 0;
        f->writable = 0;
    }
    else
    {
        f->readable = !(omode & O_WRONLY);
        f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    }
    // ++++++++++++++++++

    // f->readable = !(omode & O_WRONLY);
    // f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    // printf("====== 4 =======\n");
    if ((omode & O_TRUNC) && ip->type == T_FILE)
    {
        itrunc(ip);
    }

    iunlock(ip);
    end_op();

    return fd;
}

uint64 sys_mkdir(void)
{
    char path[MAXPATH];
    struct inode *ip;

    begin_op();
    // if (argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
     if (argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0)) == 0)
    {
        end_op();
        return -1;
    }
    iunlockput(ip);
    end_op();
    return 0;
}

uint64 sys_mknod(void)
{
    struct inode *ip;
    char path[MAXPATH];
    int major, minor;

    begin_op();
    if ((argstr(0, path, MAXPATH)) < 0 || argint(1, &major) < 0 ||
        argint(2, &minor) < 0 ||
        (ip = create(path, T_DEVICE, major)) == 0)
        // (ip = create(path, T_DEVICE, major, minor)) == 0)
    {
        end_op();
        return -1;
    }
    iunlockput(ip);
    end_op();
    return 0;
}

uint64 sys_chdir(void)
{
    char path[MAXPATH];
    struct inode *ip;
    struct proc *p = myproc();

    begin_op();
    if (argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0)
    {
        end_op();
        return -1;
    }
    ilock(ip);
    if (ip->type != T_DIR)
    {
        iunlockput(ip);
        end_op();
        return -1;
    }
    iunlock(ip);
    iput(p->cwd);
    end_op();
    p->cwd = ip;
    return 0;
}

uint64 sys_exec(void)
{
    char path[MAXPATH], *argv[MAXARG];
    int i;
    uint64 uargv, uarg;

    if (argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0)
    {
        return -1;
    }
    memset(argv, 0, sizeof(argv));
    for (i = 0;; i++)
    {
        if (i >= NELEM(argv))
        {
            goto bad;
        }
        if (fetchaddr(uargv + sizeof(uint64) * i, (uint64 *)&uarg) < 0)
        {
            goto bad;
        }
        if (uarg == 0)
        {
            argv[i] = 0;
            break;
        }
        argv[i] = kalloc();
        if (argv[i] == 0)
            goto bad;
        if (fetchstr(uarg, argv[i], PGSIZE) < 0)
            goto bad;
    }

    int ret = exec(path, argv);

    for (i = 0; i < NELEM(argv) && argv[i] != 0; i++)
        kfree(argv[i]);

    return ret;

bad:
    for (i = 0; i < NELEM(argv) && argv[i] != 0; i++)
        kfree(argv[i]);
    return -1;
}

uint64 sys_pipe(void)
{
    uint64 fdarray; // user pointer to array of two integers
    struct file *rf, *wf;
    int fd0, fd1;
    struct proc *p = myproc();

    if (argaddr(0, &fdarray) < 0)
        return -1;
    if (pipealloc(&rf, &wf) < 0)
        return -1;
    fd0 = -1;
    if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
    {
        if (fd0 >= 0)
            p->ofile[fd0] = 0;
        fileclose(rf);
        fileclose(wf);
        return -1;
    }
    if (copyout(p->pagetable, fdarray, (char *)&fd0, sizeof(fd0)) < 0 ||
        copyout(p->pagetable, fdarray + sizeof(fd0), (char *)&fd1,
                sizeof(fd1)) < 0)
    {
        p->ofile[fd0] = 0;
        p->ofile[fd1] = 0;
        fileclose(rf);
        fileclose(wf);
        return -1;
    }
    return 0;
}

/* TODO: Access Control & Symbolic Link */
int strcmp(const char *s1, const char *s2) {
    while (*s1 && (*s1 == *s2)) {
        s1++;
        s2++;
    }
    return *(const unsigned char *)s1 - *(const unsigned char *)s2;
}

char *strcpy(char *s, const char *t)
{
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
        ;
    return os;
}

void chmod_recursive(struct inode *dp, int mode, int set)
{
    struct dirent de;
    struct inode *ip;
    int off;

    for (off = 0; off < dp->size; off += sizeof(de)) {
        if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
            continue;
        if (de.inum == 0)
            continue;
        if (strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
            continue;

        if ((ip = iget(dp->dev, de.inum)) == 0)
            continue;

        ilock(ip);


        if (set)
            ip->mode |= mode;
        else
            ip->mode &= ~mode;

        iupdate(ip);

        if (ip->type == T_DIR)
            chmod_recursive(ip, mode, set);
        
        // printf("!!!!!!2\n");
        iunlockput(ip);
    }
}

uint64 sys_chmod(void)
{
    /* just for your reference, change it if you want to */

    // char path[MAXPATH];
    // int mode;
    // struct inode *ip;

    // begin_op();
    // if (argstr(0, path, MAXPATH) < 0 || argint(1, &mode) < 0 ||
    //     (ip = namei(path)) == 0)
    // {
    //     end_op();
    //     return -1;
    // }
    // end_op();
    char path[MAXPATH];
    int mode, recursive, set;
    struct inode *ip;

    if (argstr(0, path, MAXPATH) < 0 ||
        argint(1, &mode) < 0 ||
        argint(2, &recursive) < 0 ||
        argint(3, &set) < 0)
        return 1;  // Format error

    begin_op();

    if ((ip = namei_follow(path)) == 0){
        end_op();
        return 2; // File doesn't exist
    }
    ilock(ip);
    if (ip->type == T_SYMLINK) {
        ip = follow_symlink(ip, 0, 0);  // depth = 0
        if (ip == 0) {
            iunlockput(ip);
            end_op();
            return 2;
        }
        if ((ip->mode & M_READ) == 0 && ip->type==T_DIR && recursive){
            iunlockput(ip);
            end_op();
            return 2;
        }
    }
    // ilock(ip);
    // // Permission check
    // if ((ip->mode & M_READ) == 0 && set)
    // {
    //     //printf("!!!!!!!!!!1\n");
    //     iunlockput(ip);
    //     end_op();
    //     return 2;
    // }

    if (set)
        ip->mode |= mode;
    else
        ip->mode &= ~mode;

    iupdate(ip);

    if (recursive && ip->type == T_DIR) {
        chmod_recursive(ip, mode, set);
    }
    // printf("!!!!!!1\n");
    iunlockput(ip);
    end_op();

    return 0;
}

/* TODO: Access Control & Symbolic Link */
uint64 sys_symlink(void)
{
    /* just for your reference, change it if you want to */

    // char target[MAXPATH], path[MAXPATH];

    // if (argstr(0, target, MAXPATH) < 0 || argstr(1, path, MAXPATH) < 0)
    //     return -1;

    char target[MAXPATH], path[MAXPATH];
    struct inode *ip;

    // Fetch arguments
    if (argstr(0, target, MAXPATH) < 0 || argstr(1, path, MAXPATH) < 0)
        return -1;

    begin_op();

    // Check if path already exists
    if (namei(path) != 0) {
        end_op();
        return -1;
    }

    // Create a new inode with T_SYMLINK type
    // ip = create(path, T_SYMLINK, 0, 0);
    ip = create(path, T_SYMLINK, 0);
    if (ip == 0) {
        end_op();
        return -1;
    }

    // Write the target path into the inode
    if (writei(ip, 0, (uint64)target, 0, strlen(target)) != strlen(target)) {
        iunlockput(ip);
        end_op();
        return -1;
    }

    iunlockput(ip);
    end_op();
    return 0;
}

// add readlink to get resolved path
uint64 sys_readlink(void)
{
    char path[MAXPATH];
    char *buf;
    struct inode *ip;
    struct inode *resolved;
    int len;

    // Get the arguments from user space
    if (argstr(0, path, MAXPATH) < 0 || argaddr(1, (uint64 *)&buf) < 0) {
    return -1;
    }

    begin_op();
    ip = namei(path);
    if (ip == 0) {
    end_op();
    return -1;
    }

    ilock(ip);
    resolved = follow_symlink(ip, 0, 1); // recursively follow with read=1
    
    if (resolved == 0 || resolved->type != T_SYMLINK) {
        iunlockput(ip);
        end_op();
        return -1;
    }

    char target[MAXPATH] = {0};
    len = readi(resolved, 0, (uint64)target, 0, MAXPATH);
    // iunlockput(resolved);  // unlock and put the resolved inode
    end_op();

    if (len <= 0) {
        return -1;
    }

    // now safely copy from kernel buffer to user buffer
    if (copyout(myproc()->pagetable, (uint64)buf, target, len) < 0) {
      return -1;
    }
    return len;
}


uint64 sys_raw_read(void)
{
    int pbn;
    uint64 user_buf_addr;
    struct buf *b;

    if (argint(0, &pbn) < 0 || argaddr(1, &user_buf_addr) < 0)
    {
        return -1;
    }

    if (pbn < 0 || pbn >= FSSIZE)
    {
        return -1;
    }

    b = bget(ROOTDEV, pbn);
    if (b == 0)
    {
        return -1;
    }

    virtio_disk_rw(b, 0);

    struct proc *p = myproc();
    if (copyout(p->pagetable, user_buf_addr, (char *)b->data, BSIZE) < 0)
    {
        brelse(b);
        return -1;
    }

    brelse(b);
    return 0;
}

uint64 sys_get_disk_lbn(void)
{
    struct file *f;
    int fd;
    int file_lbn;
    uint disk_lbn;

    if (argfd(0, &fd, &f) < 0 || argint(1, &file_lbn) < 0)
    {
        return -1;
    }

    if (!f->readable)
    {
        return -1;
    }

    struct inode *ip = f->ip;

    ilock(ip);

    disk_lbn = bmap(ip, file_lbn);

    iunlock(ip);

    return (uint64)disk_lbn;
}

uint64 sys_raw_write(void)
{
    int pbn;
    uint64 user_buf_addr;
    struct buf *b;

    if (argint(0, &pbn) < 0 || argaddr(1, &user_buf_addr) < 0)
    {
        return -1;
    }

    if (pbn < 0 || pbn >= FSSIZE)
    {
        return -1;
    }

    b = bget(ROOTDEV, pbn);
    if (b == 0)
    {
        printf("sys_raw_write: bget failed for PBN %d\n", pbn);
        return -1;
    }
    struct proc *p = myproc();
    if (copyin(p->pagetable, (char *)b->data, user_buf_addr, BSIZE) < 0)
    {
        brelse(b);
        return -1;
    }

    b->valid = 1;
    virtio_disk_rw(b, 1);
    brelse(b);

    return 0;
}
