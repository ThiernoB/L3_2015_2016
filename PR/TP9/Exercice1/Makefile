JC 		= javac
JVM 	= java
JFLAGS 	= -g
Serveur = Serveur
Client 	= Client
SOURCES = $(wildcard *.java)
CLASSES = $(SOURCES:.java=.class)

all: $(CLASSES)

%.class : %.java
	$(JC) $(JFLAGS) $<

serv: $(Serveur).class
	$(JVM) $(Serveur)
	
client: $(Client).class
	$(JVM) $(Client)

clean: 
	rm -rf $(CLASSES)
