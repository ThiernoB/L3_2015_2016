#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "mysh.h"

/* _____________________________________________________ */
// Synopsis:  exit [STATUS]
int execute_command_exit(int argc, char** argv) {
    if (argc == 1)
        exit(0);
    if (argc > 2) {
        fprintf(stderr, "exit: Un argument au maximum.\n");
        return 1;
    }
    char* endptr;  // Indiquera où 'strlol' s'est arrêté.
    int val = strtol(argv[1], &endptr, 10);
    if (*endptr != '\0') {
        fprintf(stderr, "exit: Argument doit etre un entier.\n");
        return 1;
    }
    if (val < 0) {
        fprintf(stderr, "exit: Argument doit etre >= 0.\n");
        return 1;
    }
    exit(val);
}

/* _____________________________________________________ */
// Synopsis:  status
int execute_command_status(int argc, char** argv) {
    if (argc != 1) {
        fprintf(stderr, "status: Ne prend pas d'argument.\n");
        return 1;
    }
    printf("%d\n", status);
    return 0;
}

/* _____________________________________________________ */
// Synopsis:  cd [DIRECTORY]
int execute_command_cd(int argc, char** argv) {
    char* path;
    char buf[1024];
    if (argc > 2) {
        fprintf(stderr, "cd: Un argument au maximum.\n");
        return 1;
    }
    if (argc == 2) {
        path = argv[1];
        if (strcmp(path, "-") == 0 && 
            (path = getenv("OLDPWD")) == NULL) {
            fprintf(stderr, "cd: Historique vide.\n");
            return 1;
            
        }
    } else if ((path = getenv("HOME")) == NULL) {
        fprintf(stderr, "cd: Erreur d'acces a $HOME.\n");
        return 1;
    }
    if (chdir(path) == -1) {
        if (access(path, F_OK) == -1)
            fprintf(stderr, "cd: %s n'existe pas.\n", path);
        else if (access(path, X_OK) == -1)
            fprintf(stderr, "cd: Acces interdit.\n");
        else
            fprintf(stderr, "cd: Echec de l'operation.\n");
        return 1;
    }
    getcwd(buf, 1024);  // On veut le chemin absolu.
    setenv("OLDPWD", getenv("PWD"), 1);
    setenv("PWD", buf, 1);
    return 0;
}

/* _____________________________________________________ */
// Synopsis:  pwd
int execute_command_pwd(int argc, char** argv) {
    char* path;
    if (argc != 1) {
        fprintf(stderr, "pwd: Ne prend pas d'argument.\n");
        return 1;
    }
    if ((path = getenv("PWD")) == NULL) {
        fprintf(stderr, "pwd: Erreur d'acces a $PWD.\n");
        return 1;
    }
    printf("%s\n", path);
    return 0;
}

/* _____________________________________________________ */
// Synopsis:  jobs
int execute_command_jobs(int argc, char** argv) {
    if (argc != 1) {
        fprintf(stderr, "jobs: Ne prend pas d'argument.\n");
        return 1;
    }
    display_running_jobs();
    return 0;
}

int execute_command_kill(int argc, char** argv)
{
	if(argc == 1)
	{
		fprintf(stderr, "kill : utilisation :kill [-s sigspec | -n signum | -sigspec] pid | jobspec ... ou kill -l [sigspec]\n");
		return 1;
	}

	return 0;
}
