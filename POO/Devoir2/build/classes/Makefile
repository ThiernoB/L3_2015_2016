JAVAC = javac
SOURCES = $(wildcard *.java)
CLASSES = $(SOURCES:.java=.class)
MAINQUIZZ = MainQuizz
MAINBANQUE = MainBanqueAleatoire
JVM = java

all: $(CLASSES)

clean :
	rm -f *.class

%.class : %.java
	$(JAVAC) $<

quizz: $(MAINQUIZZ).class
	$(JVM) $(MAINQUIZZ)

banque: $(MAINBANQUE).class
	$(JVM) $(MAINBANQUE)