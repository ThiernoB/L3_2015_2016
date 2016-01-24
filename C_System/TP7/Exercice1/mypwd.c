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
#include <sys/stat.h>
#include <sys/types.h>

#define PATH_LENGHT_MAX 1024
#define ERROR -1

int main(int argc, char **argv)
{
	char *path;

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