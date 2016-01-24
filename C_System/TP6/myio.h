/*
*	@author		Pierre Dibo
* 	@email		rg26.warforce[at]hotmail.fr
*	@date 		15 nov. 2015 at 23:52:23
*/

#ifndef MYIO_INCLUDED_H
#define MYIO_INCLUDED_H

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

#define MY_NULL 0
#define MY_EOF -1
#define MY_FOPEN_MAX 64
#define MY_BUFSIZ 1024

typedef struct MY_FILE {
	int fd;
	int flags;
	unsigned char *buf;
	unsigned char *pos;
	int count;
} MY_FILE;

extern MY_FILE* mystdin;
extern MY_FILE* mystdout;
extern MY_FILE* mystderr;

MY_FILE* myfopen(const char *FILE, const char *MODE);
int myfclose(MY_FILE* FP);
int myfgetc(MY_FILE* FP);
int myfputc(int CH, MY_FILE* FP);

int fillbuffer(MY_FILE* FP);
int flushbuffer(int c, MY_FILE* FP);

char* myfgets(char* s, int size, MY_FILE* FP);
int myfputs(const char* s, MY_FILE* FP);

long myftell(MY_FILE* FP);
int myfseek(MY_FILE* FP, long offset, int whence);

#endif