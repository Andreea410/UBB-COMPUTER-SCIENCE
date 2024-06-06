//2. Write a C program that receives strings containing any characters as command-line arguments. The program will create a frequency vector for all lowercase letters of the alphabet.The program will create a thread for each command-line argument, each thread will update the letter frequency vector based on the characters present in its corresponding command-line argument. Use efficient synchronization.

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <string.h>

typedef struct
{
        int *vector;
        pthread_mutex_t mutex;
        char *string;
        int max_count;
}data;

void *f(void *arg)
{
        data* d = (data *)arg;
        char* str = malloc(sizeof(char)*100);
        str = d->string;
        pthread_mutex_unlock(&d->mutex);
        for(int i = 0;i<strlen(str);i++)
        {
                pthread_mutex_lock(&d->mutex);
                d->vector[d->string[i]-'a']++;
                if((d->string[i]-'a') > d->max_count)
                        d->max_count = d->string[i]-'a';
                pthread_mutex_unlock(&d->mutex);
        }
        return NULL;
}

int main(int argc , char* argv[])
{
        if(argc < 2)
        {
                printf("Provide some arguments\n");
                exit(1);
        }

        pthread_t* threads = malloc(sizeof(pthread_t)* (argc+1));
        int* v = malloc(sizeof(int)* 30);

        data* d =malloc(sizeof(data));
        d->vector = v;

        pthread_mutex_t mu;
        pthread_mutex_init(&mu,NULL);
        d->mutex = mu;

        d->max_count = 0;
        char* str = malloc(sizeof(char)*10);
        d->string = str;

        for(int i = 1;i < argc;i++)
        {
                pthread_mutex_lock(&d->mutex);
                d->string = argv[i];
                pthread_create(&threads[i],NULL,f,d);
        }

        for(int i = 1;i < argc;i++)
                pthread_join(threads[i],NULL);

        for(int i = 0;i <=d->max_count;i++)
                printf("%c count id : %d\n" ,i+'a',d->vector[i]);

}
