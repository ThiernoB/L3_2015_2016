JC = javac
JVM = java
JFLAGS = -g
SOURCES = $(wildcard *.java)
MAIN = Main

CLASSES = $(SOURCES:.java=.class)

all: $(CLASSES)

%.class : %.java
	$(JC) $(JFLAGS) $<

run: $(MAIN).class
	$(JVM) $(MAIN)

clean: 
	rm -rf $(CLASSES)
