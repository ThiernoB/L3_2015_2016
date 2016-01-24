/*
*	@author		Pierre Dibo
* 	@email		rg26.warforce[at]hotmail.fr
*	@date 		15 nov. 2015 at 23:58:29
*/

#include "myio.h"

#define _READ 1 // Fichier en mode lecture.
#define _WRITE 2 // Fichier en mode ecriture.
#define _NOBUF 4 // On n’utilise pas de buffer.
#define _EOF 8 // Fin de fichier atteinte.
#define _ERROR 16 // Une erreur s’est produite.

MY_FILE files[MY_FOPEN_MAX] = { 
	{0, _READ, MY_NULL, MY_NULL, 0},
	{1, _WRITE, MY_NULL, MY_NULL, 0},
	{2, _WRITE | _NOBUF, MY_NULL, MY_NULL, 0} 
};

MY_FILE* mystdin = &files[0];
MY_FILE* mystdout = &files[1];
MY_FILE* mystderr = &files[2];

//TODO : all
int main(void)
{
	printf("%d\n", mystdin->fd);
	
	return EXIT_SUCCESS;
}

MY_FILE* myfopen(const char *MY_FILE, const char *MODE)
{

	if(MODE[0] == 'r')
	{
		return mystdin;
	}

	if(MODE[0] == 'w')
	{
		return mystdout;
	}
	
	if(MODE[0] == 'x')
	{
		return mystderr;
	}
	
	return NULL;
}
int myfclose(MY_FILE* FP)
{
	if(FP->buf != NULL)
		free(FP->buf);
	if(FP->pos != NULL)
		free(FP->pos);
		
	if(close(FP->fd) == -1)
		return MY_EOF;
	else
		return 0;
}

int myfgetc(MY_FILE* FP)
{

	return 0;
}

int myfputc(int CH, MY_FILE* FP)
{

	return 0;
}

int fillbuffer(MY_FILE* FP)
{

	return 0;
}

int flushbuffer(int c, MY_FILE* FP)
{

	return 0;
}


char* myfgets(char* s, int size, MY_FILE* FP)
{

	return NULL;
}

int myfputs(const char* s, MY_FILE* FP)
{

	return 0;
}

long myftell(MY_FILE* FP)
{

	return 0.0;
}

int myfseek(MY_FILE* FP, long offset, int whence)
{

	return 0;
}



