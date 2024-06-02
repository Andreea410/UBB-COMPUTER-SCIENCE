//18. Create a C program that converts all lowecase letters from the command line arguments to uppercase letters and prints the result. Use a thread for each given argument.


#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

void *f(void* arg)
{
        char* str= (char *) arg;
        for(int i = 0;i < strlen(str);i++)
                str[i]-='a'-'A';
        printf("%s\n",str);
        return str;
}

int main(int argc , char* argv[])
{
        if(argc < 2)
        {
                printf("Provide some arguments\n");
                exit(1);
        }

        pthread_t * threads = malloc(sizeof(pthread_t)* (argc+1));
        for(int i = 1;i < argc;i++)
        {
                if(pthread_create(&threads[i],NULL,f,argv[i])!=0)
                {
                        printf("Error\n");
                        exit(1);
                }
        }

        for(int i = 1;i <argc;i++)
        {
                char* result;
                if (pthread_join(threads[i], (void**)&result) != 0)
                {
                        printf("Error joining thread\n");
                        exit(1);
                }
                printf("Result from thread %d: %s\n", i, result);
        }
}
