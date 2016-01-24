#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>
#include "mysh.h"

/* Dans cette structure, on stockera les redirections*/
// par exemple pour une redirection de stdin
// si type vaut 0, il n'y a pas de redirection et sinon il y a
typedef struct _redir{
  int type;
  int filed;
} redir;

redir redirect_in(int argc, char** argv){
  redir r;
  r.type=0;
  r.filed=0;
  int i=0;
  while(i<argc && r.type==0){
    if((strcmp(argv[i],"<")==0)){
      r.type=1;
      if(argc<=i+1){
	fprintf(stderr, "mysh: Mauvaise syntaxe redirection.\n");
	r.type=-1;;
      }
      if((r.filed=open(argv[i+1],O_RDONLY))==-1){
	fprintf(stderr, "mysh: Redirectiion impossible.\n");
	r.type=-1;
      }
    }
    i++;
  }
  return r;
}

redir redirect_out(int argc, char** argv){
  redir r;
  r.type=0;
  r.filed=0;
  int i=0;
  while(i<argc && r.type==0){
    if((strcmp(argv[i],">")==0)){
      r.type=1;
      if(argc<=i+1){
	fprintf(stderr, "mysh: Mauvaise syntaxe redirection.\n");
	r.type=-1;;
      }
      if((r.filed=open(argv[i+1],O_WRONLY | O_CREAT ,S_IRWXU))==-1){
	fprintf(stderr, "mysh: Redirectiion impossible.\n");
	r.type=-1;
      }
    }
    i++;
  }
  return r;
}


redir redirect_err(int argc, char** argv){
  redir r;
  r.type=0;
  r.filed=0;
  int i=0;
  while(i<argc && r.type==0){
    if((strcmp(argv[i],">2")==0)){
      r.type=1;
      if(argc<=i+1){
	fprintf(stderr, "mysh: Mauvaise syntaxe redirection.\n");
	r.type=-1;;
      }
      if((r.filed=open(argv[i+1],O_WRONLY | O_CREAT ,S_IRWXU))==-1){
	fprintf(stderr, "mysh: Redirectiion impossible.\n");
	r.type=-1;
      }
    }
    i++;
  }
  return r;
}


int execute_command_redirect(int argc, char** argv) {
  int background = 0;
  pid_t pid;
  redir rin=redirect_in(argc,argv);
  redir rout=redirect_out(argc,argv);
  redir rerr=redirect_err(argc,argv);
  if(rin.type==-1 || rout.type==-1 || rerr.type==-1){
    return 1;
  }
    
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
  if (pid == 0){
    int pos_arg=0;
    if(rin.type!=0){
      if (dup2(rin.filed,STDIN_FILENO) == -1){
	fprintf(stderr, "mysh: dup2 stdin echoue.\n");
	exit(1);
      }
      pos_arg=pos_arg+2;
    }
    if(rout.type!=0){
      if (dup2(rout.filed,STDOUT_FILENO) == -1){
	fprintf(stderr, "mysh: dup2 sdtout echoue.\n");
	exit(1);
      }
      pos_arg=pos_arg+2;
    }
    if(rerr.type!=0){
      if (dup2(rerr.filed,STDERR_FILENO) == -1){
	fprintf(stderr, "mysh: dup2 sdterr echoue.\n");
	exit(1);
      }
      pos_arg=pos_arg+2;
    }
    if(pos_arg>=argc){
      fprintf(stderr, "mysh: too short command.\n");
      exit(1);
    }
    if(execvp(argv[pos_arg], argv+pos_arg)==-1){ 
      fprintf(stderr, "mysh: Ne peut pas executer %s.\n", argv[0]);
      exit(1);  // Termine l'enfant en cas d'erreur.
    }
    //this return should never be reached
    return 0;
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
  // puis on renvoie son code de retour
  else {
    int exitstat;
    if (waitpid(pid, &exitstat, 0) != pid) {
      fprintf(stderr, "mysh: waitpid a echoue.\n");
      return 1;
    }
    return WEXITSTATUS(exitstat);
  }
}
