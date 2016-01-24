#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include "mysh.h"
#include "piped.h"

/* _____________________________________________________ */
// Essaye d'exécuter la commande externe 'argv[0]' avec
// les arguments spécifiés dans 'argv'.
// Renvoie 1 en cas d'échec, 0 si la commande est lancée
// en arrière-plan, et le code retour de la commande sinon.
// NE TRAITE PAS LES REDIRECTIONS DAN LES COMMANDES LIEES PAR DES
// TUBES
int execute_command_external(int argc, char** argv) {
  pipedcmd pcmd[MAXPIPED];
  int np=separate_piped_proc(argc,argv,pcmd);
  int background = 0;
  pid_t pid, pid2;
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
  if(np==1){// il n'y a pas de tubes anonymes dans la commande
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
  } else {//Il y a au moins un tube anonyme dans la commande
    // On cree le fils qui fera la dernière commande
    if ((pid = fork()) == -1) {
      fprintf(stderr, "mysh: fork a echoue.\n");
      return 1;
    }
    if(pid==0){//Dans le fils
      //On crée les tubes anonymes
      int **pipes_tab=(int **)malloc(sizeof(int *)*(np-1));
      int i=0;
      for(i=0;i<np-1;i++){
	pipes_tab[i]=(int *)malloc(sizeof(int)*2);
	if(pipe(pipes_tab[i])==-1){
	  fprintf(stderr, "mysh: probleme de creation de tubes.\n");
	  return 1;
	}
      }
      //Dans la boucle qui suit, on crée np-1 fils
      //qui executeront les (np-1)-premieres commandes
      //et on fait les redirections adéquates
      for(i=0;i<np-1;i++){
	if ((pid2 = fork()) == -1) {
	  fprintf(stderr, "mysh: fork a echoue.\n");
	  return 1;
	}
	if(pid2==0){
	  if(i!=0){
	    if(dup2(pipes_tab[i-1][0],STDIN_FILENO)==-1){
	      fprintf(stderr, "mysh: problem de connexion de tubes.\n");
	      exit(1);
	    }
	  }
	  if(dup2(pipes_tab[i][1],STDOUT_FILENO)==-1){
	    fprintf(stderr, "mysh: problem de connexion de tubes.\n");
	    exit(1);
	  }
	  int k=0;
	  //on ferme tous les tubes dont on ne sert pas
	  for(k=0;k<np-1;k++){
	    if(i==0 || k!=i-1){
	      close(pipes_tab[k][0]);
	    }
	    if(k!=i){
	      close(pipes_tab[k][1]);
	    }
	  }
	  //On exécute la commande correspondante
	  if(execvp(pcmd[i].argv[0],pcmd[i].argv) == -1){
	    fprintf(stderr, "mysh: Ne peut pas executer %s.\n",
		    pcmd[i].argv[0]);
	    exit(1);  // Termine l'enfant en cas d'erreur.
	  }
	} 
      }
      //Maintenant on peut gérer le cas de la derniere commande
      //D'abord les tubes
      if(dup2(pipes_tab[np-2][0],STDIN_FILENO)==-1){
	fprintf(stderr, "mysh: problem de connexion de tubes.\n");
	exit(1);
      }
      //on ferme tous les tubes dont on ne sert pas
      int k=0;
      for(k=0;k<np-1;k++){
	if(k!=np-2){
	  close(pipes_tab[k][0]);
	}
	close(pipes_tab[k][1]);
      }
      //Si on est en background on enleve le &
      if (background) {
	pcmd[np-1].argv[pcmd[np-1].argc - 1] = NULL;
      }
      if(execvp(pcmd[np-1].argv[0],pcmd[np-1].argv) == -1){
	fprintf(stderr, "mysh: Ne peut pas executer %s.\n",
		pcmd[np-1].argv[0]);
	exit(1);  // Termine l'enfant en cas d'erreur.
      }
    } else {
      //Dans le processus père on attend la fin de la dernière
      //commande sauf si celle-ci est en background
      if (background) {
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
  }
  return 0;
}
