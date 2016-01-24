CC=gcc
CFLAGS=
LFLAGS=
EXEC_MYIO=myio

all : $(EXEC_MYIO)

$(EXEC_MYIO) : myio.o

myio.o : myio.c myio.h
	$(CC) -o $@ -c $< $(CFLAGS)
	
cleanobj :
	rm -rf *.o
	rm -rf *.stackdump

clean : cleanobj
	rm -rf $(EXEC_MYIO)