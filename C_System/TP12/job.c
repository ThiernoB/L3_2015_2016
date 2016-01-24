#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include "mysh.h"

static int jobcount = 0;      // Nombre de jobs.
static pid_t jobtab[MAXJOB];  // Tableau de jobs.

/* _____________________________________________________ */
// Indique si 'jobtab' est plein.
int job_table_full() {
    return (jobcount == MAXJOB);
}

/* _____________________________________________________ */
// Ajoute procesuss 'pid' à 'jobtab' et renvoie son indice.
int add_job(pid_t pid) {
    int jid;
    for (jid = 0; jid < MAXJOB; ++jid) {
        if (jobtab[jid] == 0) {
            jobtab[jid] = pid;
            ++jobcount;
            return jid;
        }
    }
    return -1;
}

/* _____________________________________________________ */
// Affiche la liste des jobs en cours d'exécution.
void display_running_jobs() {
    int jid;
    pid_t pid;
    for (jid = 0; jid < MAXJOB; ++jid) {
        if ((pid = jobtab[jid]) != 0)
            printf("[%d] %d\n", jid, pid);
    }
}

/* _____________________________________________________ */
// Supprime de 'jobtab' les processus terminés.
void refresh_job_table() {
    int jid;
    pid_t pid;
    int exitstat;
    for (jid = 0; jid < MAXJOB; ++jid) {
        // La condition détermine si une case est non vide
        // et le processus associé a terminé son exécution.
        if ((pid = jobtab[jid]) != 0 &&
            waitpid(pid, &exitstat, WNOHANG) == pid) {
            jobtab[jid] = 0;
            --jobcount;
            printf("mysh: [%d] %d termine ", jid, pid);
            printf("(retour %d)\n", WEXITSTATUS(exitstat));
        }
    }
}
