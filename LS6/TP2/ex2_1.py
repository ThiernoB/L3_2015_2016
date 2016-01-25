# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys

def mult(integer):
    l = list()
    i = integer

    if(integer != 5 and integer != 7):
        print(l)
        return l
    
    while i < 200:
        if(i % integer == 0):
            l.append(i)
        i += 1
    print(l)
    return l

def pair_list(int_list):
    l = list()
    for i in int_list:
        if(i % 2 == 0):
            l.append(i)
    print(l)
    return l

def couple_list(l1, l2):
    l = list()
    if(len(l1) != len(l2)):
        print("Les deux listes ne comportent pas le même nombre d'éléments")
        return l
    else:
        l = list(zip(l1, l2))
        print(l)
        return l
def main():
    try:
        i = int(sys.argv[1])
    except IndexError:
        i = int(input("5 ou 7 ?\n"))

    print("a")
    l = mult(i)
    print("b")
    l = pair_list(l)
    print("c")
    try:
        l1 = list(sys.argv[2])
        l2 = list(sys.argv[3])
    except IndexError:
        l1 = list(input("Première liste du couple :\n"))
        l2 = list(input("Seconde liste du couple :\n"))

    couple_list(l1, l2)

if __name__ == "__main__":
    main()
    #os.system("pause")
