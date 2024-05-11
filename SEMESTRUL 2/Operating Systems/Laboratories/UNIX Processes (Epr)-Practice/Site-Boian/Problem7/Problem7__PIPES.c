//7. Write a C program that creates two child processes. The two child processes will alternate sending random integers between 1 and 10 (inclusively) to one another until one of them sends the number 10. Print messages as the numbers are sent.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc , char* argv[])
{
        int c1_to_c2[2],c2_to_c1[2];
        if(pipe(c1_to_c2)==-1)
        {
                printf("Error on pipe from child 1\n");
                exit(1);
        }
        if(pipe(c2_to_c1)==-1)
        {
                printf("Error on pipe from child 2\n");
                exit(1);
        }
        int process=fork();
        if(process == -1)
        {
                printf("Error on the first fork\n");
                exit(1);
        }
        else if(process == 0)
        {
                close(c1_to_c2[0]);
                close(c2_to_c1[1]);
                int number=0;
                if(read(c2_to_c1[0],&number , sizeof(number))==-1)
                {
                        printf("Error on reading in child 1");
                        exit(1);
                }
                printf("Child 1 read: %d\n", number);
                srand(time(NULL));
                while(number!=10)
                {
                        number=rand()%11;
                        if(write(c1_to_c2[1],&number,sizeof(number))==-1)
                        {
                                printf("Error on writting in child 1\n");
                                exit(1);
                        }
                        printf("Child 1 wrote: %d\n",number);
                        if(number ==10)
                                break;
                        if(read(c2_to_c1[0],&number,sizeof(number))==-1)
                        {
                                printf("Error on reading in child 1");
                                exit(1);
                        }
                        printf("Child 1 read: %d\n",number);
                }
                close(c1_to_c2[1]);
                close(c2_to_c1[0]);
                exit(0);
        }

        process = fork();
        if(process == -1)
        {
                printf("Error on the second fork\n");
                exit(1);
        }
        else if(process == 0)
        {
                close(c1_to_c2[1]);
                close(c2_to_c1[0]);
                int number=0;
                srand(time(NULL));
                while(number!=10)
                {
                        number=rand()%11;
                        if(write(c2_to_c1[1],&number,sizeof(number))==-1)
                        {
                                printf("Error on writting in child 2");
                                exit(1);
                        }
                        printf("Child 2 wrote: %d\n",number);
                        if(number == 10)
                                break;
                        if(read(c1_to_c2[0],&number,sizeof(number))==-1)
                        {

                                printf("Erron on reading in child 2\n");
                                exit(1);
                        }
                        printf("Child 2 read: %d\n",number);
                }
                close(c2_to_c1[1]);
                close(c1_to_c2[0]);
                exit(0);
        }
        wait(0);
        wait(0);

        return 0;
}
