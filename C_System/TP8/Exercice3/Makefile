CC=gcc
CFLAGS=
LFLAGS=
EXEC_MYCHAT=mychat

all : $(EXEC_MYCHAT)

$(EXEC_MYCHAT) : mychat.o

mychat.o : mychat.c mychat.h
	$(CC) -o $@ -c $< $(CFLAGS)
	
cleanobj :
	rm -rf *.o
	rm -rf *.stackdump

clean : cleanobj
	rm -rf $(EXEC_MYCHAT)