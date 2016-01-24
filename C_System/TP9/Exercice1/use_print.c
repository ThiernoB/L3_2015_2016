#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <err.h>
#include <unistd.h>
#include <sys/wait.h>

#define PATH_LENGHT_MAX 1024

void main(int argc, char **argv)
{
	char path[] = "./print.exe";
	pid_t p1, p2;

	if (argc != 3)
	{
		printf("%s: 2 entiers demande.\n", argv[0]);
		exit(EXIT_FAILURE);
	}


	if ((p1 = fork()) == -1) {
		warn("fork()\n");
		exit(EXIT_FAILURE);
	}
	
	if ((p2 = fork()) == -1) {
		warn("fork()\n");
		exit(EXIT_FAILURE);
	}

	if (p1 == 0)
	{
		if (execl("./print.exe", argv[1], argv[2], 0) == -1)
			exit(EXIT_FAILURE);
		exit(EXIT_SUCCESS);
	}

	if (p2 == 0)
	{
		if (execl("./print.exe", argv[1], argv[2], 0) == -1)
			exit(EXIT_FAILURE);
		exit(EXIT_SUCCESS);
	}

	exit(EXIT_SUCCESS);
}