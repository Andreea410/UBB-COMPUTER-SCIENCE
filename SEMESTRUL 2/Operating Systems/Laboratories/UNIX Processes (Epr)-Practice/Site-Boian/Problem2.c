#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(int argc ,char* argv[])
{
        if(argc!=2)
        {
                perror("Please introduce one argument.");
                exit(1);
        }
        int n=atoi(argv[1]);
        for(int i=0;i<n;i++)
        {
                int process=fork();
                if(process==-1)
                        perror("ERror on fork");
                else if(process == 0)
                        printf("Child process: %d -PID: %d -PPID: %d\n",i,getpid(),getppid());
                else
                {
                        printf("Parent %d -Child: %d\n" ,getpid(),process);
                        wait(NULL);
                        exit(0);
                }

        }


}
