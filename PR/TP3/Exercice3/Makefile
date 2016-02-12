JC = javac
JVM = java
JFLAGS = -g
SOURCES = $(wildcard *.java)
Serveur = Serveur
Client = Client
Const = Constant

CLASSES = $(SOURCES:.java=.class)

all: $(CLASSES)

%.class : %.java
	$(JC) $(JFLAGS) $<

serv: $(Const).class $(Serveur).class
	$(JVM) $(Serveur)
	
client: $(Const).class $(Client).class
	$(JVM) $(Client)

clean: 
	rm -rf $(CLASSES)
