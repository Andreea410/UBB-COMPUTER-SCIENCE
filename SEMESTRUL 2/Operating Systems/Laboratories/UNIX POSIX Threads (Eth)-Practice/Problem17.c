//17. Write a C program that reads a number N and creates 2 threads. One of the threads will generate an even number and will append it to an array that is passed as a parameter to the thread. The other thread will do the same, but using odd numbers. Implement a synchronization between the two threads so that they alternate in appending numbers to the array, until they reach the maximum length N.


#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct{
int n;
int* arr;
pthread_mutex_t mutex;
}data;


void *f1(void* arg)
{
        data* d = (data*)arg;
        for(int i = 0;i<d->n;i+=2)
        {
                pthread_mutex_lock(&d->mutex);
                int number = rand()%100;
                while(number %2)
                        number = rand()%100;
                d->arr[i] = number;
                pthread_mutex_unlock(&d->mutex);
        }

}

void *f2(void* arg)
{
        data* d = (data*)arg;
        for(int i = 1;i<d->n;i+=2)
        {
                pthread_mutex_lock(&d->mutex);
                int number = rand()%100;
                while(number %2 == 0)
                        number = rand()%100;
                d->arr[i] = number;
                pthread_mutex_unlock(&d->mutex);
        }
}

int main(int argc , char* argv[])
{
        if(argc != 2)
        {
                printf("You need to provide ONE argument\n");
                exit(1);
        }
        srand(time(NULL));
        int N = atoi(argv[1]);
        pthread_t t1;
        pthread_t t2;
        data* d = malloc(sizeof(data));
        int *array = malloc(sizeof(int)*(N+1));
        d->arr = array;
        d->n =N;
        pthread_mutex_t mutex;
        pthread_mutex_init(&mutex,NULL) ;

        if(pthread_create(&t1,NULL,f1,d)!=0)
        {
                printf("Error on creating thread\n");
                exit(1);
        }
        if(pthread_create(&t2,NULL,f2,d)!=0)
        {
                printf("Error on creating thread\n");
                exit(1);
        }

        pthread_join(t1,NULL);
        pthread_join(t2,NULL);

        for(int i = 0;i < N; i++)
                printf("%d, ",d->arr[i]);



}
