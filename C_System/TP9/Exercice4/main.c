#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <wait.h>
#include <sys/types.h>

void main(int argc, char **argv)
{
	int N, i;
	pid_t pid;
	
	if(argc != 2)
		exit(EXIT_FAILURE);

	if((N = atoi(argv[1])) == 0)
		exit(EXIT_FAILURE);
		
	//pids = (pid_t*)malloc(sizeof(pid_t) * N);

	int nbPr[N], status;

	for (i = 0; i < N; i++)
	{
		pid = fork();
		
		if (pid == 0)
		{
			exit(i);
		}
		pid = wait(&status);
		nbPr[N] = (WEXITSTATUS(status));
	}
	//free(pids);
	
	for(i = 0; i < N; i++)
	{
		printf("nbPr = %d\n", nbPr[i]);
	}
	
	exit(EXIT_SUCCESS);
}