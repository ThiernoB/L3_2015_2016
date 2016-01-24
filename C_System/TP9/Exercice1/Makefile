CC=gcc
CFLAGS=
LFLAGS=
EXEC_USE=use_print
EXEC_PRINT=print

all : $(EXEC_USE) $(EXEC_PRINT)

$(EXEC_PRINT) : print.o

$(EXEC_USE) : use_print.o 

print.o : print.c
	$(CC) -o $@ -c $< $(CFLAGS)

use_print.o : use_print.c
	$(CC) -o $@ -c $< $(CFLAGS)
	
cleanobj :
	rm -rf *.o
	rm -rf *.stackdump

clean : cleanobj
	rm -rf $(EXEC_USE)