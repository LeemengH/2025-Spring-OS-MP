#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char *fmtname(char *path)
{
    static char buf[DIRSIZ + 1];
    char *p;

    // Find first character after last slash.
    for (p = path + strlen(path); p >= path && *p != '/'; p--)
        ;
    p++;

    // Return blank-padded name.
    if (strlen(p) >= DIRSIZ)
        return p;
    memmove(buf, p, strlen(p));
    memset(buf + strlen(p), ' ', DIRSIZ - strlen(p));
    return buf;
}

/* TODO: Access Control & Symbolic Link */
void ls(char *path)
{
    char buf[512],buffer[512], *p;
    // char buf[512], resolved[512], *p;
    int fd;
    struct dirent de;
    struct stat st;
    
    // Helper function to convert mode int to string
    char *mode_to_str(int mode)
    {
        static char m[3];
        m[0] = (mode & M_READ) ? 'r' : '-';
        m[1] = (mode & M_WRITE) ? 'w' : '-';
        m[2] = '\0';
        return m;
    }
    // ++++++++++++++++++++
    if (stat(path, &st) < 0)
    {
        // printf("<1>\n");
        printf("ls: cannot open %s\n", path);
        return;

    }
    // printf("its type from stat() is %d\n", st.type);
    // ++++++++++++++++++++
    if  (st.type == T_SYMLINK){
        // printf("aaaaaaaaaaaaaa\n");
        if ((fd = open(path, 0)) < 0)
        {
            // printf("<2>\n");
            fprintf(2, "ls: cannot open %s\n", path);
            return;
        }

        if (fstat(fd, &st) < 0)
        {
            // printf("<3>\n");
            fprintf(2, "ls: cannot open %s\n", path);
            close(fd);
            return;
        }
        switch (st.type)
        {
        case T_FILE:
            close(fd);
            if (stat(path, &st) < 0)
            {
                printf("ls: cannot open %s\n", path);
                return;

            }
            printf("%s %d %d %d %s\n", fmtname(path), st.type, st.ino, st.size, mode_to_str(st.mode));
            break;

        case T_DIR:
            
            // if (readlink(path, buffer) >= 0)
            //     printf("Resolved path: %s\n", buffer);
            // else
            //     printf("readlink failed\n");
            readlink(path, buffer);
            
            if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf)
            {
                printf("ls: path too long\n");
                break;
            }
            strcpy(buf, buffer);
            p = buf + strlen(buf);
            *p++ = '/';


            while (read(fd, &de, sizeof(de)) == sizeof(de))
            {
                if (de.inum == 0)
                    continue;
                memmove(p, de.name, DIRSIZ);
                p[DIRSIZ] = 0;
                if (stat(buf, &st) < 0)
                {
                    printf("ls: cannot open %s\n", buf);
                    continue;
                }

                printf("%s %d %d %d %s\n", fmtname(buf), st.type, st.ino, st.size, mode_to_str(st.mode));
            }
            break;
        }
        // printf("aaaaaaaaaaaaaa\n");
    }else{
        // printf("bbbbbbbbbbbbb\n");
        if ((fd = open(path, 0)) < 0)
        {
            // printf("<4>\n");
            fprintf(2, "ls: cannot open %s\n", path);
            return;
        }

        if (fstat(fd, &st) < 0)
        {
            // printf("<5>\n");
            fprintf(2, "ls: cannot open %s\n", path);
            close(fd);
            return;
        }

        // printf("Type of file = %d\n", st.type);
        switch (st.type)
        {
        case T_FILE:
        case T_DEVICE:
            printf("%s %d %d %d %s\n", fmtname(path), st.type, st.ino, st.size, mode_to_str(st.mode));
            break;

        case T_DIR:
            if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf)
            {
                printf("ls: path too long\n");
                break;
            }
            strcpy(buf, path);
            p = buf + strlen(buf);
            *p++ = '/';

            while (read(fd, &de, sizeof(de)) == sizeof(de))
            {
                if (de.inum == 0)
                    continue;
                memmove(p, de.name, DIRSIZ);
                p[DIRSIZ] = 0;
                // printf("bbbbbbb< de.name = %s >bbbbbbbbb\n", de.name);
                if (stat(buf, &st) < 0)
                {
                    printf("ls: cannot stat %s\n", buf);
                    continue;
                }

                printf("%s %d %d %d %s\n", fmtname(buf), st.type, st.ino, st.size, mode_to_str(st.mode));
            }
            break;
        }
        // printf("bbbbbbbbbbbbb\n");
    }    

    close(fd);
}


int main(int argc, char *argv[])
{
    int i;

    if (argc < 2)
    {
        ls(".");
        exit(0);
    }
    for (i = 1; i < argc; i++)
        ls(argv[i]);
    exit(0);
}
