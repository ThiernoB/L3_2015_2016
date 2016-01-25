# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys

def inclus(l1, l2):
    if(len(l1) != len(l2)):
        #print("La première liste n'est pas inclus dans la seconde.")
        return False

    while len(l1) > 0:
        obj1 = l1.pop()
        obj2 = l2.pop()

        if(obj1 != obj2):
            #print("La première liste n'est pas inclus dans la seconde.")
            return False
        
    #print("La première liste est inclus dans la seconde.")
    return True

def main():
    try:
        s1 = [int(i) for i in sys.argv[1]]
        s2 = [int(i) for i in sys.argv[2]]
        print(inclus(s1, s2))
    except IndexError:
        s1 = input("Entrez une première liste d'entiers\n")
        s2 = input("Entrez une seconde liste d'entiers\n")
        s1 = [int(i) for i in s1]
        s2 = [int(i) for i in s2]
        print(inclus(s1, s2))
    

if __name__ == "__main__":
    main()
    #os.system("pause")
