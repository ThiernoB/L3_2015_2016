#include <stdio.h>
#include <stdlib.h>
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
    // ##############################
    // ## À vous d'écrire le code. ##
    // ##############################
    return 0;  // <-- Ceci est juste un "garde-place".
}

/* _____________________________________________________ */
// Synopsis:  cd [DIRECTORY]
int execute_command_cd(int argc, char** argv) {
    // ##############################
    // ## À vous d'écrire le code. ##
    // ##############################
    return 0;  // <-- Ceci est juste un "garde-place".
}

/* _____________________________________________________ */
// Synopsis:  pwd
int execute_command_pwd(int argc, char** argv) {
    // ##############################
    // ## À vous d'écrire le code. ##
    // ##############################
    return 0;  // <-- Ceci est juste un "garde-place".
}
