JC = javac
JVM = java
JFLAGS = -g
SOURCES = $(wildcard *.java)
Serveur = ThreadedServer
Player = PlayerService
Client = Client
Const = Constant

CLASSES = $(SOURCES:.java=.class)

all: $(CLASSES)

%.class : %.java
	$(JC) $(JFLAGS) $<

serv: $(Const).class $(Player).class $(Serveur).class 
	$(JVM) $(Serveur)
	
client: $(Const).class $(Client).class
	$(JVM) $(Client)
	
clean: 
	rm -rf $(CLASSES)
