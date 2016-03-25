#ifndef TUTEUR_INCLUDED_H
#define TUTEUR_INCLUDED_H

#include "libs.h"

#define MAX_TUTEUR 			9
#define DISCIPLINE_SIZE 	(4 * sizeof(char))

#define ADD_FAILURE				"Erreur interne"
#define ADD_FAILURE_MAX_TUTEUR	"Nombre maximum de tuteur atteint"
#define ADD_FAILURE_EXIST		"Le tuteur existe déjà"
#define DEL_FAILURE_ZERO		"Aucun tuteur dans la liste à supprimer"

typedef struct tuteur {
	uint16_t id;
	char* discipline;
} tuteur;

typedef struct list_tuteurs {
	int size;
	tuteur** tuteurs;
} list_tuteurs;

void ListTuteur_Init();
void ListTuteur_Free();
void ListTuteur_Display();

int ListTuteur_Add(uint16_t id, char* discip);
int ListTuteur_Del(uint16_t del);

tuteur* Tuteur_Init(uint16_t id, char* discip);
void Tuteur_Display(tuteur* t);

#endif

