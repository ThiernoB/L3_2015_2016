/*
**  Pierre Dibo
**  rgv26.warforce@hotmail.fr
**	Universite Diderot Paris 7 - Licence 3 Informatique
**	Systeme - TP7: Excercice 1
**	09/11/2015
*/

#include <stdlib.h> 
#include <stdio.h>
#include <string.h>
#include <dirent.h>
#include <unistd.h>
#include <err.h>
#include <sys/stat.h>
#include <sys/types.h>

#define PATH_LENGHT_MAX 1024
#define ERROR -1

int main(int argc, char **argv)
{
	char *path;
	int i, k;

	if (argc != 2)
	{
		warn("Nombre de parametres positionnels incorrect\n.");
		return EXIT_FAILURE;
	}

	k = atoi(argv[1]);

	for (i = 0; i < k; i++) 
	{
		if (chdir("../") == ERROR)
		{
			break;
		}
	}

	if ((path = getcwd(NULL, PATH_LENGHT_MAX)) == NULL)
	{
		return EXIT_FAILURE;
	}
	else
	{
		printf("%s\n", path);
	}

	return EXIT_SUCCESS;
}