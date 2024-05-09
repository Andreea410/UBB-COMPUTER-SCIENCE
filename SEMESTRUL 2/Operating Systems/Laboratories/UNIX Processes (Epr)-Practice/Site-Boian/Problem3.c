#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>

int process;
void child_handling(int signal)
{
        printf("Child process terminating...\n");
        exit(0);
}

void parent_handling(int signal)
{
        printf("Parent process terminating..\n");
        kill(process,SIGUSR1);
        wait(0);
        exit(0);
}

void zombie_handling(int signal)
{
        printf("Parent waiting for the child process to terminate\n");
        wait(0);
}

int main(int argc , char* argv[])
{
        process=fork();
        if(process == -1)
        {
                printf("Error on fork");
                exit(1);
        }
        else if(process == 0)
        {
                signal(SIGUSR1,child_handling);//standar C function --takes the signal and the function that will handle the signals as parameters
                printf("C - Child PID: %d Parent PID: %d\n", getpid(),getppid());
                while(1)
                {
                        printf("Child working...\n");
                        sleep(3);
                }
                exit(0);

        }
        else
        {
                signal(SIGUSR1,parent_handling);
                signal(SIGCHLD,zombie_handling);
                while(1) {
                        printf("Parent working...\n");
                                sleep(2);
                }

        }
        return 0;
}
