# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys
import re

def double(s):
    if (len(s) % 2 == 0):
        i = int(len(s) / 2)
        if(s[:i] == s[i:len(s)]):
            return s[:i]
        else:
            return None
    else:
        return None

def contientdouble(s):
    if(len(double(s)) >= 2):
        return double(s)
    else:
        return None

def extraire_ligne(s):
    s = s.replace(" ", "")
    s = s.replace("\n", "")
    regexp = r"([0-9]{4},[0-9]+,[0-9]+,[a-zA-Z0-9_])"
    if re.match(regexp, s) is not None:
        s = s.split(",")
        (annee, nombre, id, prenom) = (s[0], s[1], s[2], s[3])
        return (annee, nombre, id, prenom)
    else:
        None

def extraire_fichier(f):
    d = dict()
    file = open(f, "r")
    for line in file:
        if(extraire_ligne(line) == None):
            continue

        (annee, nombre, id, prenom) = extraire_ligne(line)
        
        if((prenom, annee) in d):
            i = int(d.get((prenom, annee))) + int(nombre)
            d.update({(prenom, annee):i})
        else:
            d.update({(prenom, annee):int(nombre)})
    
    file.close()

    return d

def popularite(d):
    print("TODO")
    return None

def main():
    #name = "ii"
    #print(double(name))
    #print(contientdouble(name))
    string = "1981, 3, 11, Zohir\n"
    #print(extraire_ligne(string))
    d = extraire_fichier("prenoms.txt")
    #print(d.get(("Petronille", "1908")))

    popularite(d)

if __name__ == "__main__":
    main()
    #os.system("pause")
