//29. Write a C program that reads a number n from standard input and creates n threads, numbered from 0 to n - 1. Each thread places a random number between 10 and 20 on the position indicated by its id in an array of integers. After all threads have placed their number in the array, each thread repeats the following:
//- Checks if the number on its own position is greater than 0.
//- If yes, it substracts 1 from all numbers of the array, except the one on its own position.
//- If not, the thread terminates.
//- If there are no numbers in the array that are greater than 0, except the number on the thread's index position, the thread terminates.
//After all threads terminate, the main process prints the array of integers. Use appropriate synchronization mechanisms.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

typedef struct
{
        int *array;
        int n;
        pthread_mutex_t mutex;
}data;

void *f(void *arg)
{
        data *d = (data *)arg;
        pthread_mutex_lock(&d->mutex);

        int number =  rand()%20;
        while(number < 10)
                number = rand()%20;
        printf("Thread %d just generated %d\n" ,d->n,number);
        d->array[d->n] = number;
        d->n++;

        int  ok=0;
        for(int i =0;i < d->n-1;i++)
                if(d->array[i] > 0)
                        ok = 1;
        if(ok)
                for(int i =0;i < d->n-1;i++)
                        d->array[i]-=1;
        pthread_mutex_unlock(&d->mutex);
        return NULL;
}

int main(int argc , char* argv[])
{
        if(argc != 2)
        {
                printf("Provide ONE argument\n");
                exit(1);
        }

        int n = atoi(argv[1]);
        pthread_t *threads = malloc(sizeof(pthread_t)*(n+1));
        data* d = malloc(sizeof(data));
        d->n = 0;
        int *arr = malloc(sizeof(int)*(n+1));
        d->array = arr;

        pthread_mutex_t mutex;
        pthread_mutex_init(&mutex,NULL);
        d->mutex = mutex;

        for(int i = 0 ;i < n;i++)
        {
                pthread_create(&threads[i],NULL,f,d);
        }

        for(int i = 0;i < n;i++)
                pthread_join(threads[i],NULL);
        for(int i =0;i < d->n;i++)
                        printf("%d,",d->array[i]);

}
