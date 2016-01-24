/*
*	@author		Pierre Dibo
* 	@email		rg26.warforce[at]hotmail.fr
*	@date		14 nov. 2015 at ‏‎09:28:09
*/


#include <libgen.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <err.h>
#include <dirent.h>
#include <unistd.h>
#include <fcntl.h> 
#include <pwd.h>
#include <time.h>
#include <grp.h>
#include <sys/stat.h>
#include <sys/types.h>

#define DEFAULT_DIRECTORY "."

#define PATH_LENGTH_MAX 1024
#define TIME_LENGTH 30
#define MAX_PATH 16
#define ERROR -1

void ls_from_directory(char *dir);

void ls_args(int argc, char **path);

void ls(int argc, char **path, int *args, int size);

void print_permissions(struct stat *status);

int option_a = 0, option_l = 0, option_r = 0, option_d = 0, option_R = 0;


int main(int argc, char **argv)
{
	int err = ERROR;

	if (argc == 1)
	{
		ls_from_directory(DEFAULT_DIRECTORY);
	}
	else
	{
		ls_args(argc, argv);
	}

	return EXIT_SUCCESS;
}

void ls_from_directory(char *dir)
{
	struct stat status;
	struct dirent *entry;
	DIR *rep;
	int i = 0, k = 1;

	if ((rep = opendir(dir)) == NULL)
	{
		perror("opendir - ls_from_current_directory()\n");
		return;
	}

	while ((entry = readdir(rep)) != NULL)
	{
		if (!option_a)
		{
			if (entry->d_name[0] == '.')
				continue;
		}

		if (stat(entry->d_name, &status) == ERROR)
		{
			warn(" impossible acceder a %s: ", entry->d_name);
			continue;
		}

		if (!option_l)
		{
			printf("%s  ", entry->d_name);

			if (k++ % 5 == 0)
				printf("\n");
		}

		else
		{
			print_permissions(&status);
			printf("%s\n", entry->d_name);
		}
	}
	closedir(rep);
}

void ls_args(int argc, char **path)
{
	int args[argc];
	int i, j = 0;


	for (i = 1; i < argc; i++)
	{
		if (!strcmp(path[i], "-d"))
		{
			option_d = 1;
			args[j++] = i;
			continue;
		}

		if (!strcmp(path[i], "-a"))
		{
			option_a = 1;
			args[j++] = i;
			continue;
		}

		if (!strcmp(path[i], "-R"))
		{
			option_R = 1;
			args[j++] = i;
			continue;
		}

		if (!strcmp(path[i], "-r"))
		{
			option_r = 1;
			args[j++] = i;
			continue;
		}

		if (!strcmp(path[i], "-l"))
		{
			option_l = 1;
			args[j++] = i;
		}
	}
	ls(argc, path, args, j);
}

void ls(int argc, char **path, int *args, int size)
{
	struct stat status;
	struct dirent *entry;
	DIR *rep;
	int i, j = 0;

	if (argc == 2 && (option_a || option_d || option_l || option_R || option_r))
		ls_from_directory(DEFAULT_DIRECTORY);

	for (i = 1; i < argc; i++)
	{
		if (i == args[j])
		{
			j++;
			continue;
		}

		if (stat(path[i], &status) == ERROR)
		{
			warn(" impossible acceder a %s: ", path[i]);
			continue;
		}

		if (S_ISDIR(status.st_mode))
		{
			ls_from_directory(path[i]);
		}

		if (S_ISREG(status.st_mode))
		{
			if (!option_l)
				printf("%s  ", path[i]);
			else
			{
				print_permissions(&status);
				printf("%s\n", path[i]);
			}
		}

		if (S_ISLNK(status.st_mode))
		{
			if (!option_l)
				printf("%s  ", path[i]);
			else
			{
				print_permissions(&status);
				printf("%s\n", path[i]);
			}
		}
	}
}

void print_permissions(struct stat *status)
{
	struct passwd *pwd;
	char date[TIME_LENGTH];

	pwd = getpwuid(status->st_uid);

	if (S_ISDIR(status->st_mode))
		printf("d");
	else
		printf("-");

	if (status->st_mode & S_IRUSR)
		printf("r");
	else
		printf("-");

	if (status->st_mode & S_IWUSR)
		printf("w");
	else
		printf("-");

	if (status->st_mode & S_IXUSR)
		printf("x");
	else
		printf("-");

	if (status->st_mode & S_IRGRP)
		printf("r");
	else
		printf("-");

	if (status->st_mode & S_IWGRP)
		printf("w");
	else
		printf("-");

	if (status->st_mode & S_IXGRP)
		printf("x");
	else
		printf("-");

	if (status->st_mode & S_IROTH)
		printf("r");
	else
		printf("-");

	if (status->st_mode & S_IWOTH)
		printf("w");
	else
		printf("-");

	if (status->st_mode & S_IXOTH)
		printf("x");
	else
		printf("-");

	if (S_ISDIR(status->st_mode))
		printf("+  ");
	else
		printf("  ");


	printf("%-8.8s", pwd->pw_name);

	printf("%d  ", status->st_size);

	strftime(date, TIME_LENGTH, "%d  %B  %H:%M", localtime(&(status->st_mtime)));

	fflush(stdout);
	printf("%s  ", date);

}


