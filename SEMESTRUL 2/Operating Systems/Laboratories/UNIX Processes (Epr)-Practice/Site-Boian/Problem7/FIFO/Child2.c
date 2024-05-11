#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <errno.h>
#include <sys/types.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <time.h>

int main(int argc , char* argv[])
{
        if(mkfifo("c2_to_c1",0777)==-1)
                if(errno != EEXIST)
                {
                        printf("Error on creating second FIFO\n");
                        exit(1);
                }
        int rd=open("c1_to_c2",O_RDONLY);
        if(rd==-1)
        {
                printf("Error on readin in FIFO 1\n");
                exit(1);
        }
        int wr = open("c2_to_c1",O_WRONLY);
        if(wr ==-1)
        {
                printf("Error on writting FIFO 2\n");
                exit(1);
        }
        int process = fork();
        if(process == -1)
        {
                printf("Error on fork in child 2\n");
                exit(1);
        }
        else if(process == 0)
        {
                int number = 0;
                srand(time(NULL));
                while(number!=10)
                {
                number = rand()%11;
                if(write(wr,&number,sizeof(number))==-1)
                {
                        printf("Error on writting child 2\n");
                        exit(1);
                }
                printf("Child 2 wrote: %d\n",number);
                if(number == 10)
                        break;
                if(read(rd,&number,sizeof(number))==-1)
                {
                        printf("Error on reading child 2\n");
                        exit(1);
                }
                printf("Child 2 read: %d\n",number);
                }
                close(wr);
                close(rd);
                return 0;
        }
        wait(0);
        return 0;
}
