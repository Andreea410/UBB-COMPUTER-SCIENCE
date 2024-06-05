//1. Write a C program that creates N threads (N given as a command line argument). The threads will keep adding random numbers between -500 and +500 to a shared variable that initially has the value 0. The threads will terminate when the shared variable has an absolute value greater than 500. Ensure proper synchronization Print a message every time a thread modifies the variable.

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>

typedef struct
{
        int sharedNumber;
        pthread_mutex_t mutex;
}data;

void *f(void *arg)
{
        int number;
        data *d = (data *)arg;
        while (abs(d->sharedNumber) < 500)
        {
                pthread_mutex_lock(&d->mutex);
                number = rand()%1001-500;
                printf("Generated %d\n",number);
                d->sharedNumber+=number;
                pthread_mutex_unlock(&d->mutex);

        }
        return NULL;
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

        pthread_t *threads = malloc(sizeof(pthread_t)*(n+1));
        data* d = malloc(sizeof(data));
        d->sharedNumber = 0;

        pthread_mutex_t mu;
        pthread_mutex_init(&mu,NULL);
        d->mutex = mu;

        for(int i = 0;i < n;i++)
                pthread_create(&threads[i],NULL,f,d);

        for(int i = 0;i < n;i++)
                pthread_join(threads[i],NULL);



        return 0;

}
