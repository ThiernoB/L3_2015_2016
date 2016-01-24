#include <stdio.h>
#include <string.h>
#include "piped.h"

/* ______________________________________________________ */
// D�coupe la commande 'argv' de taille 'argc' en
// diff�rents arguments s�par�s par '|'. Dans le tableau
// 'pc', chaque case correspond � un processus.
// Par exemple, pour la commande 'ls | more', on aura dans
// 'pc' deux cases, la 1�re contiendra 'ls', la 2�me 'more'.
// Renvoie le nombre de processus � cr�er (pour 'ls | more',
// la fonction renverra 2.
int separate_piped_proc(int argc, char **argv, pipedcmd *pc) {
    int i = 0;
    int j = 0;
    int k = 0;
    while (i < argc) {
        if (strcmp(argv[i], "|") == 0) {
            pc[j].argc = k;
            j++;
            k = 0;
        } else {
            (pc[j].argv)[k] = argv[i];
            k++;
        }
        i++;
    }
    pc[j].argc = k;
    return (j+1);
}
