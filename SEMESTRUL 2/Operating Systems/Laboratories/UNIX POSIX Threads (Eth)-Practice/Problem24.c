//Write a C program that creates N threads and one child process (N given as a command line argument). Each thread will receive a unique id from the parent. Each thread will generate two random numbers between 1 and 100 and will print them together with its own id. The threads will send their generated numbers to the child process via pipe or FIFO. The child process will calculate the average of each pair of numbers received from a thread and will print it alongside the thread id. Use efficient synchronization

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/types.h>
#include <sys/wait.h>

typedef struct
{
        int a;
        int b;
        int id;
}data;

void* f(void* arg)
{
        srand(pthread_self());
        data* d = malloc(sizeof(data));
        int nr = rand()%100 + 1;
        int nr2=rand()%100 +1;

        d->a = nr;
        d->b = nr2;
        d->id = pthread_self();
        printf("Thread with ID:(%d) just generated %d and %d\n",pthread_self(),nr,nr2);
        return d;
}


int main(int argc , char* argv[])
{
        if(argc != 2)
        {
                printf("Provide ONE argument\n");
                exit(1);
        }
        srand(time(NULL));
        int n = atoi(argv[1]);
        int fd[2];
        pipe(fd);
        int process=fork();
        if(process != 0)
        {
                close(fd[0]);
                pthread_t* threads = malloc(sizeof(pthread_t)*(n+1));
                for(int i=0;i < n;i++)
                {
                        pthread_create(&threads[i],NULL,f,NULL);
                }
                for(int i=0;i < n;i++)
                {
                        data *d = malloc(sizeof(data));
                        pthread_join(threads[i],(void**)&d);
                        write(fd[1],d,sizeof(data));
                }
                wait(0);
                srand(pthread_self());
                return 0;
        }
        else if(process == 0)
        {
                close(fd[1]);
                int sum = 0;
                data *d = malloc(sizeof(data));
                for(int i = 0;i < n;i++)
                {
                        sum = 0;
                        read(fd[0],d,sizeof(data));
                        sum = (d->a + d->b)/2;
                        printf("Thread %d has the average %d\n",d->id,sum);

                }

        }
        return 0;
}
