# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys

def mails(f):
    for s in f.read().split(";"):
        if ("@" not in s) is False and ("etu" not in s) is False:
            print(s)

def main():
    f1 = open("inscrits.csv", "r")
    f2 = open("emargement.csv", "w+")

    s = ""
    i = 0

    f2.write("Prenom, Nom\n")
    
    for line in f1:
        if ("etu" not in line) is False:
            s += line

    l = s.split(";")
    
    while i < len(l) - 2:
        s1 = l[i + 2]
        s2 = l[i + 1]
        s = s1 + ", " + s2 + "\n"
        print(s)
        f2.write(s)
        i += 4
        
    f1.close()
    f2.close()

if __name__ == "__main__":
    main()
    #os.system("pause")
