CC=gcc
CFLAGS=-Wall -pedantic -std=c99 -D _POSIX_C_SOURCE=200112L
LFLAGS=
EXEC_DIC=main

all : $(EXEC_DIC)

$(EXEC_DIC) : main.o dictionnaire.o
	$(CC) -o $(EXEC_DIC) $^ $(LFLAGS)
	
dictionnaire.o : dictionnaire.c dictionnaire.h
	$(CC) -o $@ -c $< $(CFLAGS)

main.o : main.c
	$(CC) -o $@ -c $< $(CFLAGS)

cleanobj :
	rm -rf *.o
	rm -rf *.stackdump

clean : cleanobj
	rm -rf $(EXEC_DIC)