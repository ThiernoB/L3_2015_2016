#include <stdio.h>
#include <string.h>
#include "mysh.h"

int status;  // Code de retour de la dernière commande.

/* _____________________________________________________ */
int main() {
    int argc;            // Nombre d'arguments.
    char argl[MAXLIN];   // Ligne de commande "brute".
    char* argv[MAXVEC];  // Tableau d'arguments.
    // On désactive le buffer de 'stdout'.
    // (Sinon il faudrait parfois utiliser 'fflush'.)
    setvbuf(stdout, NULL, _IONBF, 0);
    status = 0;
    // Boucle infinie pouvant être interrompue par 'exit'.
    while (1) {
        // On affiche l'invite de commande.
        display_prompt();
        // On récupère la commande de l'utilisateur.
        read_command(argl);
        // On découpe cette commande en arguments.
        argc = tokenize_command(argl, argv);
        // On essaye d'exécuter la commande,
        // et on stocke la valeur de retour.
        status = execute_command(argc, argv);
    }
}

/* _____________________________________________________ */
// Affiche l'invite de commande sur 'stdout'.
void display_prompt() {
    printf(PROMPT);
}

/* _____________________________________________________ */
// Lit la prochaine ligne de commande depuis 'stdin'.
void read_command(char* argl) {
    if (fgets(argl, MAXLIN, stdin) == NULL) {
        // Si l'utilisateur tape Ctrl+D,
        // on interprète ceci comme "exit".
        strcpy(argl, "exit");
        printf("exit\n");
    } 
}

/* _____________________________________________________ */
// Découpe la ligne 'argl' au niveau des séparateurs ARGSEP
// et stocke un pointeur sur chaque argument dans 'argv'.
// (Les séparateurs dans 'argl' sont remplacés par '\0'.)
int tokenize_command(char* argl, char** argv) {
    int i;
    argv[0] = strtok(argl, ARGSEP);
    for (i = 0; argv[i] != NULL; ++i)
        argv[i+1] = strtok(NULL, ARGSEP);
    return i;
}

/* _____________________________________________________ */
// Essaye d'exécuter la commande spécifiée par 'argv',
// et renvoie son code de retour ou 1 en cas d'échec.
// Le travail est effectué par des fonctions auxiliaires.
// Cette fonction choisit seulement laquelle appeler.
int execute_command(int argc, char** argv) {
    if (argc == 0)
        return status;
    if (strcmp(argv[0], "exit") == 0)
        return execute_command_exit(argc, argv);
    // ##############################################
    // ## À vous d'ajouter les appels nécessaires. ##
    // ##############################################
    // La branche suivante est juste un "garde-place".
    // À SUPPRIMER !
    else {
        fprintf(stderr, "Ne comprend pas %s.\n", argv[0]);
        return 1;
    }
}
