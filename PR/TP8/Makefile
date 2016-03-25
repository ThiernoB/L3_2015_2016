CC = gcc
CFLAGS = -pthread
CLT = clt
SERV = serv
HEADERS = $(wildcard *.h)
OBJECTS = $(patsubst %.c, %.o, $(wildcard *.c))

all: $(SERV) $(CLT) cleanobj
	
$(CLT): client.o
	$(CC) -o $(CLT) $^ $(CFLAGS)

$(SERV): tuteur.o serveur.o
	$(CC) -o $(SERV) $^ $(CFLAGS)
	
client.o: client.c
	$(CC) -o $@ -c $< $(CFLAGS)

tuteur.o: tuteur.c tuteur.h
	$(CC) -o $@ -c $< $(CFLAGS)

serveur.o: serveur.c
	$(CC) -o $@ -c $< $(CFLAGS)
	
cleanobj:
	rm -f $(OBJECTS) *~ *.*~
	
clean: cleanobj
	rm -f $(SERV) $(CLT) *.stackdump *.exe
