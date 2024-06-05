//20. Write a C program that takes as command line arguments 2 numbers: N and M. The program will simulate a thread race that have to pass through M checkpoints. Through each checkpoint the threads must pass one at a time (no 2 threads can be inside the same checkpoint). Each thread that enters a checkpoint will wait between 100 and 200 milliseconds (usleep(100000) makes a thread or process wait for 100 milliseconds) and will print a message indicating the thread number and the checkpoint number, then it will exit the checkpoint. Ensure that no thread will try to pass through a checkpoint until all threads have been created.


#include <stdio.h>
#include<unistd.h>
#include <stdlib.h>
#include <pthread.h>

typedef struct
{
        int m;
        int n;
        int id;
        pthread_mutex_t mutex;
        pthread_barrier_t barrier;
}data;

void *f(void * arg)
{
        data *d = (data *)arg;
        int id = d->id;
        printf("Process %d waiting ...\n",id);
        pthread_mutex_unlock(&d->mutex);
        pthread_barrier_wait(&d->barrier);
        for(int i = 0;i < d->m;i++)
        {
                int number = rand()%100+100;
                printf("Thread %d entered %d checkpoint\n",id,i+1);
                usleep(number);
                pthread_mutex_unlock(&d->mutex);
        }
        return NULL;
}


int main(int argc , char*argv[])
{
        if(argc !=3)
        {
                printf("You need to provide TWO arguments\n");
                exit(1);
        }
        int n = atoi(argv[1]);
        int m = atoi(argv[2]);

        data *d = malloc(sizeof(data))  ;
        d->m = m;
        pthread_mutex_t mu;
        pthread_mutex_init(&mu,NULL);

        d->mutex = mu;
        pthread_barrier_t barrier;
        pthread_barrier_init(&barrier,NULL,n);
        d->barrier = barrier;

        pthread_t *threads = malloc(sizeof(pthread_t)*(n+1));

        for(int i = 0;i < n ;i++)
        {
                pthread_mutex_lock(&d->mutex);
                d->id = i+1;
                pthread_create(&threads[i],NULL,f,d);
        }
        for(int i = 0;i < n;i++)
                pthread_join(threads[i],NULL);

        pthread_barrier_destroy(&d->barrier);


        return 0;
}
