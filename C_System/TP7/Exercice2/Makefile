CC=gcc
CFLAGS=-Wall -pedantic -std=c99 -D _POSIX_C_SOURCE=200112L
LFLAGS=
EXEC_TREEDIR=treedir

all : $(EXEC_TREEDIR)

$(EXEC_TREEDIR) : treedir.o
	$(CC) -o $(EXEC_TREEDIR) $^ $(LFLAGS)
	
treedir.o : treedir.c treedir.h
	$(CC) -o $@ -c $< $(CFLAGS)
	
	
cleanobj :
	rm -rf *.o
	rm -rf *.stackdump

clean : cleanobj
	rm -rf $(EXEC_TREEDIR)