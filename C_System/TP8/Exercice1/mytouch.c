/*
*	@author		Pierre Dibo
* 	@email		rg26.warforce[at]hotmail.fr
*	@date 		09 ‎nov. ‎2015 at ‏‎‏‎18:19:31
*/

#include "mytouch.h"

static struct timespec newtime[2];
static struct tm tm;
int option_a = 0, option_m = 0, option_d = 0;

int main(int argc, char **argv)
{
	if (argc < 2)
	{
		printf(MISSING_OP);
		return EXIT_FAILURE;
	}

	arguments(argc, argv);

	return EXIT_SUCCESS;
}

void arguments(int argc, char **argv)
{
	int args[argc];
	int i, j = 0;

	for (i = 1; i < argc; i++)
	{
		if (!strcmp(argv[i], "--help"))
		{
			touch_help();
			return;
		}

		if (!strcmp(argv[i], "-a"))
		{
			option_a = 1;
			args[j++] = i;
			continue;
		}

		if (!strcmp(argv[i], "-m"))
		{
			option_m = 1;
			args[j++] = i;
			continue;
		}

		if (!strcmp(argv[i], "-am"))
		{
			option_a = 1;
			option_m = 1;
			args[j++] = i;
		}

		if (!strcmp(argv[i], "-d"))
		{
			args[j++] = i;
			if (strptime(argv[++i], "%Y-%m-%dT%H:%M:%S", &tm) == NULL)
			{
				printf("mytouch: format de date \u00AB %s \u00BB incorrect\n", argv[i]);
				return;
			}
			option_d = 1;
			args[j++] = i;
		}
	}

	j = 0;

	for (i = 1; i < argc; i++)
	{
		if (i == args[j])
		{
			j++;
			continue;
		}

		if (!option_d && !option_a && !option_m)
		{
			default_touch(argv[i]);
			continue;
		}
		if (!option_d)
			mytouch(argv[i]);
		else
			mytouch_d(argv[i]);
	}

}

void default_touch(const char *str)
{
	mode_t mode_file;
	int handle;


	mode_file = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;

	if (access(str, F_OK) == ERROR)
	{

		if ((handle = creat(str, mode_file)) == ERROR)
		{
			warn(" creat - default_touch\n");
			return;
		}

		if (futimens(handle, NULL) == ERROR)
		{
			warn(" fudimens - default_touch.\n");
			return;
		}
		close(handle);
	}
	else
	{
		if (utimensat(AT_FDCWD, str, NULL, FLAG) == ERROR)
		{
			warn(" fudimens - default_touch.\n");
			return;
		}
	}
}

void mytouch(const char *str)
{
	mode_t mode_file;
	int handle;

	if (option_a)
	{
		newtime[0].tv_sec = UTIME_NOW;
		newtime[0].tv_nsec = UTIME_NOW;
	}
	else
	{
		newtime[0].tv_sec = UTIME_OMIT;
		newtime[0].tv_nsec = UTIME_OMIT;
	}

	if (option_m)
	{
		newtime[1].tv_sec = UTIME_NOW;
		newtime[1].tv_nsec = UTIME_NOW;
	}
	else
	{
		newtime[1].tv_sec = UTIME_OMIT;
		newtime[1].tv_nsec = UTIME_OMIT;
	}

	mode_file = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;

	if (access(str, F_OK) == ERROR)
	{

		if ((handle = creat(str, mode_file)) == ERROR)
		{
			warn(" creat - arguments\n");
			return;
		}

		if (futimens(handle, newtime) == ERROR)
		{
			warn(" fudimens - arguments.\n");
			return;
		}
		close(handle);
	}
	else
	{
		if (utimensat(AT_FDCWD, str, newtime, FLAG) == ERROR)
		{
			warn(" fudimens - arguments.\n");
			return;
		}
	}
}

void mytouch_d(const char *str)
{
	struct utimbuf timebuff;
	time_t t;
	mode_t mode_file;
	int handle;

	t = mktime(&tm);

	timebuff.actime = t;
	timebuff.modtime = t;

	mode_file = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;

	if (access(str, F_OK) == ERROR)
	{

		if ((handle = creat(str, mode_file)) == ERROR)
		{
			warn(" creat - mytouch_d\n");
			return;
		}

		if (close(handle) == ERROR)
		{
			warn(" close - mytouch_d\n");
			return;
		}
	}

	if (utime(str, &timebuff) == ERROR)
	{
		warn(" utime - mytouch_d\n");
	}
}

void touch_help()
{
	printf("Utilisation : mytouch [OPTION]... FICHIER...\n");
}
