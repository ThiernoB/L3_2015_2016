#include "tuteur.h"

extern list_tuteurs *list;

void ListTuteur_Init()
{
	int i;
	
	if ((list = malloc(sizeof(*list))) == NULL)
	{	
		fprintf(stdout, "%s\n", strerror(errno));
		return;
	}

	list->size = 0;
	list->tuteurs = malloc(MAX_TUTEUR * sizeof(*list->tuteurs[0]));
	
	if (list->tuteurs == NULL)
	{
		fprintf(stdout, "%s\n", strerror(errno));
		free(list);
		return;
	}
	
	
	for (i = 0; i < MAX_TUTEUR; i++)
		list->tuteurs[i] = NULL;
	
}

void ListTuteur_Free()
{
	int i;

	for(i = 0; i < list->size; i++)
	{
		if(list->tuteurs[i] != NULL)
		{
			if(list->tuteurs[i]->discipline != NULL)
				free(list->tuteurs[i]->discipline);
			free(list->tuteurs[i]);
		}
	}
	free(list->tuteurs);
	free(list);
}


void ListTuteur_Display()
{
	int i;
	
	if(list == NULL)
		return;
	
	printf("\nNombre de tuteur(s) : %d\n", list->size);
	
	for(i = 0; i < MAX_TUTEUR; i++)
	{
		if(list->tuteurs[i] != NULL)
			Tuteur_Display(list->tuteurs[i]);
	}
	
	printf("\n");
}

int ListTuteur_Add(uint16_t id, char* discip)
{
	tuteur* val;
	int i, size;
	
	if(list->size == MAX_TUTEUR)
	{
		fprintf(stdout, "%s\n", ADD_FAILURE_MAX_TUTEUR);
		return FAILURE;
	}
	
	for (i = 0; i < MAX_TUTEUR; i++)
		if((val = list->tuteurs[i]) != NULL)
			if(val->id == id)
			{
				fprintf(stdout, "%s\n", ADD_FAILURE_EXIST);
				return FAILURE;
			}
	
	for (i = 0; i < MAX_TUTEUR; i++)
		if(list->tuteurs[i] == NULL)
			if((val = Tuteur_Init(id, discip)) == NULL)
			{
				fprintf(stdout, "%s\n", ADD_FAILURE);
				return FAILURE;
			}
			else
			{
				list->size++;
				list->tuteurs[i] = val;
				return SUCCESS;
			}

	return FAILURE;
}

int ListTuteur_Del(uint16_t del)
{
	int i;
	
	if(list->size == 0)
	{
		fprintf(stdout, "%s\n", DEL_FAILURE_ZERO);
		return FAILURE;
	}

	for (i = 0; i < MAX_TUTEUR; i++)
	{
		if(list->tuteurs[i] != NULL)
			if(list->tuteurs[i]->id == del)
			{
				list->size--;
				free(list->tuteurs[i]->discipline);
				free(list->tuteurs[i]);
				list->tuteurs[i] = NULL;
				return SUCCESS;
			}
	}
	
	return FAILURE;
}

tuteur* Tuteur_Init(uint16_t id, char* discip)
{
	tuteur* t;

	if ((t = malloc(sizeof(*t))) == NULL)
	{	
		fprintf(stdout, "%s\n", strerror(errno));
		return NULL;
	}
	
	if ((t->discipline = malloc(DISCIPLINE_SIZE)) == NULL)
	{	
		fprintf(stdout, "%s\n", strerror(errno));
		free(t);
		return NULL;
	}
	
	t->id = id;
	memset(t->discipline, 0, DISCIPLINE_SIZE);
	strncpy(t->discipline, discip, DISCIPLINE_SIZE);
	
	return t;
}

void Tuteur_Del(uint16_t del)
{
	int i;
	
	for(i = 0; i < list->size; i++)
	{
		if(list->tuteurs[i] != NULL)
		{
			if(list->tuteurs[i]->id == del)
			{
				list->size--;
				free(list->tuteurs[i]);
			}
		}
	}
}

void Tuteur_Display(tuteur* t)
{
	printf("------------- Tuteur ------------\n");
	printf("id = %" PRId16 "\n", t->id);
	printf("discipline = %s\n", t->discipline);
	printf("---------------------------------\n");
}

