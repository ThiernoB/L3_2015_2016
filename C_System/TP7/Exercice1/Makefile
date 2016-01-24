CC=gcc
#CFLAGS=-Wall -pedantic -std=c99 -D _POSIX_C_SOURCE=200112L
LFLAGS=
EXEC_MYPWD=mypwd
EXEC_MYPWD_ABOVE=mypwd_above
EXEC_BASEWD=basewd
EXEC_MYLS=myls

all : $(EXEC_MYPWD) $(EXEC_MYPWD_ABOVE) $(EXEC_BASEWD) $(EXEC_MYLS)

pwd : $(EXEC_MYPWD)

pwd_above : $(EXEC_MYPWD_ABOVE)

base : $(EXEC_BASEWD)

mls : $(EXEC_MYLS)

$(EXEC_MYPWD) : mypwd.o
	$(CC) -o $(EXEC_MYPWD) $^ $(LFLAGS)
	
mypwd.o : mypwd.c
	$(CC) -o $@ -c $< $(CFLAGS)
	
$(EXEC_MYPWD_ABOVE) : mypwd_above.o
	$(CC) -o $(EXEC_MYPWD_ABOVE) $^ $(LFLAGS)
	
mypwd_above.o : mypwd_above.c
	$(CC) -o $@ -c $< $(CFLAGS)
	
	
$(EXEC_BASEWD) : basewd.o
	$(CC) -o $(EXEC_BASEWD) $^ $(LFLAGS)
	
basewd.o : basewd.c
	$(CC) -o $@ -c $< $(CFLAGS)
	
	
$(EXEC_MYLS) : myls.o
	$(CC) -o $(EXEC_MYLS) $^ $(LFLAGS)
	
myls.o : myls.c
	$(CC) -o $@ -c $< $(CFLAGS)


cleanobj :
	rm -rf *.o
	rm -rf *.stackdump
	
clean : cleanobj
	rm -rf $(EXEC_MYPWD) $(EXEC_MYPWD_ABOVE) $(EXEC_BASEWD) $(EXEC_MYLS)
