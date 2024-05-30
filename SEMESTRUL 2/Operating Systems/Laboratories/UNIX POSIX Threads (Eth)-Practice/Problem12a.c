//12a. Write a C program that reads a matrix of integers from a file. It then creates as many threads as there are rows in the matrix, each thread calculates the sum of the numbers on a row. The main process waits for the threads to finish, then prints the sums.
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>

typedef struct{
int *row;
int cols;
}data;

void *calculate(void* arg)
{
        int sum = 0;
        data* dt = (data *) arg;
        for(int i = 0; i < dt->cols;i++)
                sum+=(dt->row[i]);
        int* result = malloc(sizeof(int));
        *result = sum;
        return result;
}

int main(int argc , char* argv[])
{
        if(argc != 2)
        {
                printf("You need to provide ONE argument\n");
                exit(1);
        }

        FILE* f = fopen(argv[1],"r");
        if(f == NULL)
        {
                printf("Error opening the file");
                exit(1);
        }
        int rows =0,cols=0;
        char buffer[1024];
        while(fgets(buffer,sizeof(buffer),f) !=NULL)
        {
                if(rows == 0)
                {
                        //calculate the cols
                        for(int i = 0; buffer[i] !='\0';i++)
                                if(buffer[i+1] !='\0' && buffer[i] == ' ' &&buffer[i+1] != ' ')
                                cols++;
                        cols++;
                }
                rows++;
        }
        int **matrix = (int **)malloc(sizeof(int *) * rows);

        for(int i = 0;i < rows;i++)
                matrix[i] = (int *)malloc(sizeof(int)*cols);

        rewind(f);

        for(int i = 0; i < rows;i++)
                for(int j=0; j < cols ;j++)
                        fscanf(f,"%d",&matrix[i][j]);

        data* dt = (data *)malloc(sizeof(data) * rows);
        pthread_t *threads = (pthread_t*)malloc(sizeof(pthread_t)*rows);
        dt->cols = cols;
        for(int i = 0; i < rows;i++)
        {
                dt[i].cols = cols;
                dt[i].row = matrix[i];
                if(pthread_create(&threads[i],NULL,calculate,(void **)&dt[i])!=0)
                {
                        printf("Error on creating the matrx\n");
                        exit(1);
                }
         }
         int *sums = (int *)malloc(sizeof(int)*rows);
         for(int i = 0; i < rows;i++)
         {
                 int* result;
                 if(pthread_join(threads[i],(void **)&result) !=0)
                 {
                         printf("Error\n");
                         exit(1);
                  }
                 sums[i] = *result;
                 free(result);
         }
         for(int i = 0; i < rows;i++)
                 printf("Row %d Sum: %d\n",i+1,sums[i]);


        return 0;

}
