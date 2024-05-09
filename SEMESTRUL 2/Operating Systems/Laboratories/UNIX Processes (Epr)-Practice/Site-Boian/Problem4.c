#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc , char* argv[])
{
        struct timeval time1,time2;//c struct --time1 has tv_sec == seconds and tv_usec == microseconds
        if(argc < 2)
        {
                printf("You need to provide one argument");
                exit(1);
        }
        gettimeofday(&time1 , NULL);
        int process=fork();
        if(process == -1)
        {
                printf("Error on fork");
                exit(1);
        }
        else if(process == 0)
        {
                if(execvp(argv[1],argv+1)==-1)//execute with path-
                {
                        printf("Error on executing the command");
                        exit(1);
                }
                return 0;
        }
        else
        {
                wait(0);
                gettimeofday(&time2,NULL);
                printf("Total time = %f seconds\n", (double)(time2.tv_usec - time1.tv_usec) / 1000000 + (double) (time2.tv_sec - time1.tv_sec));
        }
        return 0;
}
