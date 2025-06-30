#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char *my_strstr(const char *haystack, const char *needle) {
    // find neddle in haystack
    if (!*needle) return (char *)haystack; // if needle is empty 
    for (; *haystack; haystack++) { 
        const char *h = haystack, *n = needle;
        while (*h && *n && *h == *n) { 
            h++;
            n++;
        }
        if (!*n) return (char *)haystack; // totally match
    }
    return 0; //not found
}

void count_occurrences(char *path, char *key, int *count) {
    int key_len = strlen(key);
    char *p = path;
    
    while ((p = my_strstr(p, key)) != 0) {
        (*count)++;
        p += key_len;
    }
}

void traverse(char *path, char *key, int *file_count, int *dir_count) {
    int fd;
    struct stat st;
    struct dirent de;
    char buf[512], *p;
    int key_count = 0;

    if ((fd = open(path, 0)) < 0) {
        printf("%s [error opening dir]\n", path);
        return;
    }

    if (fstat(fd, &st) < 0) {
        printf("%s [error opening dir]\n", path);
        close(fd);
        return;
    }

    // only deal with directory
    if (st.type != T_DIR) {
        printf("%s [error opening dir]\n", path);
        close(fd);
        return;
    }

    // root directory key counting
    count_occurrences(path, key, &key_count);
    printf("%s %d\n", path, key_count);

    // read directory cotnet
    while (read(fd, &de, sizeof(de)) == sizeof(de)) {
        if (de.inum == 0 || strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
            continue;

        // construct path
        strcpy(buf, path);
        p = buf + strlen(buf);
        *p++ = '/';
        memmove(p, de.name, DIRSIZ);
        p[DIRSIZ] = 0;

        if (stat(buf, &st) < 0) {
            printf("ls: cannot stat %s\n", buf);
            continue;
        }

        key_count = 0;
        count_occurrences(buf, key, &key_count);

        if (st.type == T_FILE) {
            (*file_count)++;
	    printf("%s %d\n", buf, key_count);
        } else if (st.type == T_DIR) {
            (*dir_count)++;
            traverse(buf, key, file_count, dir_count); // deal with sub-directory resursively
        }
    }

    close(fd);
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: mp0 <root_directory> <key>\n");
        exit(1);
    }

    char *root = argv[1];
    char *key = argv[2];
    int file_count = 0, dir_count = 0;
    int pipefd[2];

    if (pipe(pipefd) < 0) {
        printf("Error creating pipe\n");
        exit(1);
    }

    int pid = fork();

    if (pid < 0) {
        printf("Fork failed\n");
        exit(1);
    }

    if (pid == 0) {  // child
        close(pipefd[0]);  // close read end
        traverse(root, key, &file_count, &dir_count);
        printf("\n");  // seperate child & parent
        write(pipefd[1], &file_count, sizeof(file_count));
        write(pipefd[1], &dir_count, sizeof(dir_count));
        close(pipefd[1]);  // close write end
        exit(0);
    } else {  // parent
        close(pipefd[1]);  // close write
        wait(0);  // wait child process
        read(pipefd[0], &file_count, sizeof(file_count));
        read(pipefd[0], &dir_count, sizeof(dir_count));
        close(pipefd[0]);  // close read
        printf("%d directories, %d files\n", dir_count, file_count);
    }

    exit(0);
}

