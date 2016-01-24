#include <stdio.h>
#include <stdlib.h>

void main(int argc, char **argv)
{
	int i, val1, val2;

	printf("\n");

	if((val1= atoi(argv[0])) == -1)
		exit(EXIT_FAILURE);

	if ((val2 = atoi(argv[1])) == -1)
		exit(EXIT_FAILURE);

	if (val2 > 0)
		for (i = 0; i < val2; i++)
			printf("%d\n", val1);

	exit(EXIT_SUCCESS);
}