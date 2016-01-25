# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys

def recherche(w, f):
    for line in f:
        if (w not in line) is False:
            print(line)

def main():
    try:
        file_name = sys.argv[1]
        word = sys.argv[2]
    except IndexError:
        file_name = input("Nom du fichier :\n")
        word = input("Mot à rechercher :\n")

    f = open(file_name, "r")

    recherche(word, f)

    f.close()


if __name__ == "__main__":
    main()
    #os.system("pause")
