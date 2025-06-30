#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
    int recursive = 0;
    char *permstr, *target;
    int mode = 0, set = 1;

    if (argc < 3 || argc > 4){
        fprintf(2, "Usage: chmod [-R] (+|-)(r|w|rw|wr) file_name|dir_name\n");
        exit(1); // incorrect format
    }
    if (argc == 4) {
        if (strcmp(argv[1], "-R") != 0)
            exit(1);
        recursive = 1;
        permstr = argv[2];
        target = argv[3];
    } else {
        permstr = argv[1];
        target = argv[2];
    }

    if (permstr[0] == '+') set = 1;
    else if (permstr[0] == '-') set = 0;
    else {
        fprintf(2, "Usage: chmod [-R] (+|-)(r|w|rw|wr) file_name|dir_name\n");
        exit(1);
    }
    for (int i = 1; permstr[i]; i++) {
        if (permstr[i] == 'r') mode |= M_READ;
        else if (permstr[i] == 'w') mode |= M_WRITE;
        else {
            fprintf(2, "Usage: chmod [-R] (+|-)(r|w|rw|wr) file_name|dir_name\n");
            exit(1);
        }
    }

    int ret = chmod(target, mode, recursive, set);
    if (ret == 1) fprintf(2, "Usage: chmod [-R] (+|-)(r|w|rw|wr) file_name|dir_name\n");
    else if (ret == 2) fprintf(2, "chmod: cannot chmod %s\n", target);
    exit(ret);
}
