#define MAXLIN 512           // Longueur max. d'une ligne.
#define MAXVEC (MAXLIN / 2)  // Nombre max. d'arguments.
#define ARGSEP " \t\n"       // Séparateurs d'arguments.
#define PROMPT "mysh$ "      // Invite de commande.

extern int status;  // Code retour de la dernière commande.

/* _____________________________________________________ */
// Fonctions principales.  (main.c)
// ---
void display_prompt();
void read_command(char* argl);
int tokenize_command(char* argl, char** argv);
int execute_command(int argc, char** argv);

/* _____________________________________________________ */
// Fonctions exécutant des commandes.
// ---
// Commandes internes.  (builtin.c)
int execute_command_exit(int argc, char** argv);
int execute_command_status(int argc, char** argv);
int execute_command_cd(int argc, char** argv);
int execute_command_pwd(int argc, char** argv);
// ---
// Commandes externes.  (external.c)
int execute_command_external(int argc, char** argv);
