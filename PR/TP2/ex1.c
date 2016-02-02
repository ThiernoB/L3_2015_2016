#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv)
{
	char buffer[BUFSIZ];

	while(1)
	{
		scanf("%s", buffer);
		
		if(!strcmp(buffer, "quit"))
			break;
	}

	exit(EXIT_SUCCESS);
}
