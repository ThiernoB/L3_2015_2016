# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys

def dictionnary(f):
    l1, l2 = list(), list()
    for s in f:
        array = s.split(":")
        l1.append(array[0])
        l2.append(array[1].replace("\n", ""))
        
    return dict(zip(l1, l2))

def translate(f):
    l = ""
    for s in f.read().split(" "):
        str = d.get(s)
        if str is None:
            str = s
        l += str + " "

    t = open("testtraduit.txt", "w")
    t.write(l)
    t.close()
    print(l)

def main():
    f = open("dico2.txt", "r")
    global d
    d = dictionnary(f)
    f.close()
    
    try:
        file_name = sys.argv[1]
    except IndexError:
        file_name = input("Fichier à traduire ?\n")
     
    #"testtraduction.txt"
    f = open(file_name, "r")
    translate(f)
    f.close()

    
if __name__ == "__main__":
    main()
    #os.system("pause")
