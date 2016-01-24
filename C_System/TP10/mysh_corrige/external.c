#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include "mysh.h"

/* _____________________________________________________ */
// Essaye d'exécuter la commande externe 'argv[0]' avec
// les arguments spécifiés dans 'argv'.
// Renvoie 1 en cas d'échec, 0 si la commande est lancée
// en arrière-plan, et le code retour de la commande sinon.
int execute_command_external(int argc, char** argv) {
    int background = 0;
    pid_t pid;
    // On teste s'il faut exécuter en arrière-plan.
    if (strcmp(argv[argc - 1], "&") == 0) {
        background = 1;
        argv[argc - 1] = NULL;  // Enlève "&" de 'argv'.
        // On vérifie que 'jobtab' a encore de la place.
        if (job_table_full()) {
            fprintf(stderr, "mysh: Trop de jobs.\n");
            return 1;
        }
    }
    // On essaye de créer un processus enfant.
    if ((pid = fork()) == -1) {
        fprintf(stderr, "mysh: fork a echoue.\n");
        return 1;
    }
    // Dans l'enfant, on essaye d'exécuter la commande.
    if (pid == 0 && execvp(argv[0], argv) == -1) {
        fprintf(stderr, "mysh: Ne peut pas executer %s.\n", argv[0]);
        exit(1);  // Termine l'enfant en cas d'erreur.
    }
    // Dans le parent, si on est en mode arrière-plan,
    // on déclare un nouveau job et on retourne.
    else if (background) {
        int jid = add_job(pid);
        printf("[%d] %d\n", jid, pid);
        return 0;
    }
    // Sinon, dans le parent, en mode avant-plan,
    // on attend la terminaison de l'enfant,
    // puis on renvoie son code de retour.
    else {
        int exitstat;
        if (waitpid(pid, &exitstat, 0) != pid) {
            fprintf(stderr, "mysh: waitpid a echoue.\n");
            return 1;
        }
        return WEXITSTATUS(exitstat);
    }
}
