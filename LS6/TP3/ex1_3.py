# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys
import itertools

def produit(l):
    print("Produit de ", l)
    for i in itertools.product(*l):
        print(i)
    print("")

def main():
    i = [[1], ["cd"], [2]]
    j = [[4, 5], ["cd"], [1, 2, 3]]
    k = [[]]
    
    produit(i)
    produit(j)
    produit(k)

if __name__ == "__main__":
    main()
    #os.system("pause")
