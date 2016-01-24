/*
*	@author		Pierre Dibo
* 	@email		rg26.warforce[at]hotmail.fr
*	@date 		10 ‎nov. ‎2015 at ‏‎‏‎18:19:36
*/

#ifndef MYTOUCH_INCLUDED_H
#define MYTOUCH_INCLUDED_H

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <err.h>
#include <unistd.h>
#include <fcntl.h> 
#include <time.h>
#include <utime.h>
#include <sys/stat.h>
#include <sys/types.h>

#define MISSING_OP "mytouch: operande de fichier manquant\nSaisissez << mytouch --help >> pour plus d'information"
#define FLAG 0
#define ERROR -1

void arguments(int argc, char **argv);
void mytouch(const char *str);
void mytouch_d(const char *str);
void default_touch(const char *str);
void touch_help();

#endif