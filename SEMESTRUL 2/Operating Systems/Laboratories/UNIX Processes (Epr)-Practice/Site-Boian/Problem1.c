#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc , char* argv[])
{
        if(argc != 2)
        {
                perror("Please introduce 2 arguments");
                exit(1);
        }
        int n=atoi(argv[1]);
        for(int i= 0; i<n ; i++)
        {
                int process=fork();
                if(process == -1)
                        perror("Error on fork");
                else if(process == 0)
                {
                        printf("Child %d -PID: %d -PPID: %d\n",i,getpid(),getppid());
                        exit(0);
                }
                else
                        printf("Parent %d , Child:%d\n" ,getpid(),process);
        }
        for(int i= 0; i<n ; i++)
                wait(NULL);
        return 0;

}
