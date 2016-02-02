#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <ctype.h>

int main(int argc, char **argv)
{
	char name[BUFSIZ];
	char *buffer;
	FILE *f;
	
	printf("Entrez le nom du fichier que vous voulez lire :\n");
	scanf("%s", name);

	if((f = fopen("text.txt", "r")) == NULL)
	{
		warn("NULL");
		exit(EXIT_FAILURE);
	}
	
	buffer = malloc(sizeof(char));

	while (fread(buffer, 1, sizeof(char), f) > 0)
	{
		if(!strcmp(buffer, "\n"))
			continue;
			
		if(isdigit(buffer[0]) == 0)
		{
			printf("Le fichier contient autre chose que des entiers.\n");
			free(buffer);
			fclose(f);
			exit(EXIT_FAILURE);
		}
	}
	
	printf("Le fichier contient uniquement des entiers.\n");
	
	free(buffer);
	fclose(f);

	exit(EXIT_SUCCESS);
}
