#include "common.h"

void make_fifo_if_not_exists(char *fifo_name) {
    if(0 > mkfifo(fifo_name, 0600)) {
        perror("Error on create fifo");
        exit(1);
    }
}


int main(int argc, char *argv[]) {
    make_fifo_if_not_exists(a2b);
    make_fifo_if_not_exists(b2a);
    int fd_a2b = open(a2b, O_WRONLY);
    int fd_b2a = open(b2a, O_RDONLY);
    if (0 > fd_a2b) {
        perror("Error opening a2b");
        exit(1);
    }
    if (0 > fd_b2a) {
        perror("Error opening b2a");
        exit(1);
    }

    int i, size = 0;
    for(i = 1; i < argc; i++) {
        size += strlen(argv[i]) + 1;
    }
    size++;
    char *rez = malloc(size * sizeof(char));
    memset(rez, 0, size * sizeof(char));
    for(i = 1; i < argc; i++) {
        write_to_fd(fd_a2b, argv[i]);
        int len;
        if (0 > read(fd_b2a, &len, sizeof(int))) {
            perror("Error on reading length");
        }
        char *buf = malloc((len + 1) * sizeof(char));
        read_from_fd(fd_b2a, len, buf);
        buf[len] = 0;
        strcat(rez, buf);
        strcat(rez, " ");
        free(buf);
    }
    int stop = -1;
    if (0 > write(fd_a2b, &stop, sizeof(int))) {
        perror("Error on sending stop");
    }
    rez[size-1] = 0;
    printf("%s\n", rez);
    free(rez);
    close(fd_a2b);
    close(fd_b2a);
    if (0 > unlink(a2b)) {
        perror("Error unlink a2b");
    }
    if (0 > unlink(b2a)) {
        perror("Error unlink b2a");
    }
    return 0;
}
