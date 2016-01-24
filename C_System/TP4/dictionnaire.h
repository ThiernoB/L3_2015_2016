/*
*	@author		Pierre Dibo
* 	@email		rg26.warforce[at]hotmail.fr
*	@date 		09 ‎nov. ‎2015 at ‏‎‏‎21:42:50
*/

#ifndef DICTIONNAIRE_INCLUDED_H
#define DICTIONNAIRE_INCLUDED_H

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define MAX 1024
#define ALPHABET_LENGTH 26
#define CHAR_SIZE 1

typedef struct dictionnaire_t {
	char key[ALPHABET_LENGTH][CHAR_SIZE];
	char value[ALPHABET_LENGTH];
}dictionnaire_t;

void Dictionnaire_init(dictionnaire_t *dico);

#endif