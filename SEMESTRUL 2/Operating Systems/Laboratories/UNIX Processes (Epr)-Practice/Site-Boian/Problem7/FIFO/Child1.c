#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <time.h>

int main(int argc , char* argv[])
{
        if(mkfifo("c1_to_c2",0777) == -1)
                if(errno != EEXIST)
                {
                        printf("Error on first FIFO\n");
                        exit(1);
                }
        int wr=open("c1_to_c2",O_WRONLY);
        if(wr==-1)
        {
                printf("Error on writting FIFO 1\n");
                exit(1);
        }
        int rd = open("c2_to_c1",O_RDONLY);
        if(rd==-1)
        {
                printf("Error on reading FIFO2 \n");
                exit(1);
        }
        int process =fork();
        if(process == -1)
        {
                printf("Error fork for child 1\n");
                exit(1);
        }
        else if(process == 0)
        {
                int number = 0;
                srand(time(NULL) ^ getpid());
                if(read(rd,&number,sizeof(number))==-1)
                {
                        printf("Error on reading child1\n");
                        exit(1);
                }
                printf("Child 1 read: %d\n",number);
                while(number!=10)
                {
                        number=rand()%11;
                        if(write(wr,&number,sizeof(number))==-1)
                        {
                                printf("Error on writting child1\n");
                                exit(1);
                        }
                        printf("Child 1 wrote: %d\n",number);
                        if(number == 10)
                                break;
                        if(read(rd,&number,sizeof(number))==-1)
                        {
                                printf("Error on reading child1\n");
                                exit(1);
                        }
                        printf("Child 1 read: %d\n",number);
                }
                close(rd);
                close(wr);
                exit(0);


        }
        wait(0);
        return 0;
}
