#include "common.h"

int main(int argc, char *argv[]) {
    int fd_a2b = open(a2b, O_RDONLY);
    int fd_b2a = open(b2a, O_WRONLY);
    if (0 > fd_a2b) {
        perror("Error opening a2b");
        exit(1);
    }
    if (0 > fd_b2a) {
        perror("Error opening b2a");
        exit(1);
    }

    while(1) {
        int len;
        if (0 > read(fd_a2b, &len, sizeof(int))) {
            perror("Error on reading length");
        }
        if(len < 0)
            break;
        char *buf = malloc((len + 1) * sizeof(char));
        read_from_fd(fd_a2b, len, buf);
        int i;
        for(i = 0; i < len; i++) {
            if(buf[i] >= 'a' && buf[i] <= 'z') {
                buf[i] += 'A' - 'a';
            }
        }
        buf[len] = 0;
        write_to_fd(fd_b2a, buf);
        free(buf);
    }

    close(fd_a2b);
    close(fd_b2a);
    return 0;
}
