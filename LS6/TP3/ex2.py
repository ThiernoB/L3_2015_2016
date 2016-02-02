# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys

def minimum(s):
    if(len(s) > 0):
        return s[0]
    else:
        return []

def memeslistes(l1, l2):
    return set(l1).issubset(set(l2)) and set(l1).issuperset(set(l2))

def afficher(s):
    print("--- Affichage ---")
    for c in s:
        print(c)
    print("----------------")
def ens(w):
    print("ensemble de :", w)
    s = sorted(set(w))
    return s

def main():

    s1 = "caracteres"
    s2 = "987654321"
    s1 = ens(s1)
    afficher(s1)
    print("minimum de", s1, "\n", minimum(s1))

    s2 = ens(s2)
    afficher(s2)
    print("minimum de", s2, "\n", minimum(s2))

    i = [1, 2]
    j = [1, 3]
    k = [1, 2, 2, 3, 3, 3]
    l = [1, 2, 3]
    
    print("mem entre", i, "et", i, "\n", memeslistes(i, i))

    print("mem entre", i, "et", j, "\n", memeslistes(i, j))

    print("mem entre", k, "et", l, "\n", memeslistes(k, l))

    print("mem entre", i, "et", k, "\n", memeslistes(i, k))

    print("mem entre", l, "et", j, "\n", memeslistes(i, k))

if __name__ == "__main__":
    main()
    #os.system("pause")
