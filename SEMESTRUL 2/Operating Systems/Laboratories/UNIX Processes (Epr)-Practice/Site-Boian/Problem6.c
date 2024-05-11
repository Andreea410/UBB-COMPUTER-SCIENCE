//6. Create a C program that generates N random integers (N given at the command line). It then creates a child, sends the numbers via pipe. The child calculates the average and sends the result back.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc , char* argv[])
{
        if (argc != 2)
        {
                printf("You need to provide ONE argument\n");
                exit(1);
        }
        int p_c[2] , c_p[2];
        if(pipe(p_c) == -1)
        {
                printf("Error on opening the pipe\n");
                exit(1);
        }
        if(pipe(c_p)==-1)
        {
                printf("Error on opening the pipe\n");
                exit(1);
        }

        int process = fork();
        if (process == -1)
        {
                printf("Error on fork\n");
                exit(1);
        }
        else if(process == 0)
        {
                close(p_c[1]);
                close(c_p[0]);
                int n=0;
                if(read(p_c[0],&n,sizeof(n))==-1)
                {
                        printf("Error on reading n from the parent.");
                        exit(1);
                }
                int nr;
                int sum=0;
                for(int i = 0;i<n;i++)
                        if(read(p_c[0],&nr,sizeof(nr))==-1)
                        {
                                printf("Error on reading numbers from parent\n");
                                exit(1);
                        }
                        else
                        {
                                printf("The child just read: %d\n",nr);
                                sum+=nr;
                        }
                printf("Sum: %d\n",sum);
                close(p_c[0]);
                if(write(c_p[1],&sum , sizeof(sum))==-1)
                {
                        printf("Error on writting the sum to the parent\n");
                        exit(1);
                }
                close(c_p[1]);
                return 0;
        }
        else
        {
                //we close what we don t use
                close(p_c[0]);
                close(c_p[1]);
                int n=atoi(argv[1]);
                if(write(p_c[1],&n,sizeof(n))==-1)
                {
                        printf("Error on writting\n");
                        exit(1);
                }
                srand(time(NULL));

                for(int i = 0;i<n;i++)
                {
                        int number = rand()%100;
                        if(write(p_c[1],&number , sizeof(number))==-1)
                        {
                                printf("Error on writting to the file\n");
                                exit(1);
                        }
                        printf("Parent process wrote %d\n",number);
                }
                close(p_c[1]);
                wait(0);
                int sum;
                if(read(c_p[0],&sum , sizeof(sum))==-1)
                {
                        printf("Error on reading the sum in the PARENT\n");
                        exit(1);
                }
                printf("Sum in the parent: %d\n",sum);

        }
        return 0;
}
