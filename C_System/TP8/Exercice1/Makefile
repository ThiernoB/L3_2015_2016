CC=gcc
CFLAGS=
LFLAGS=
EXEC_MYTOUCH=mytouch

all : $(EXEC_MYTOUCH)

$(EXEC_MYTOUCH) : mytouch.o

mytouch.o : mytouch.c mytouch.h
	$(CC) -o $@ -c $< $(CFLAGS)
	
cleanobj :
	rm -rf *.o
	rm -rf *.stackdump

clean : cleanobj
	rm -rf $(EXEC_MYTOUCH)