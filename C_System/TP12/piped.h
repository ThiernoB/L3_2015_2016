#include "mysh.h"
#define MAXPIPED 20

typedef struct {
    int argc;
    char *argv[MAXVEC];
} pipedcmd;

int separate_piped_proc(int argc, char **argv, pipedcmd *pc);
