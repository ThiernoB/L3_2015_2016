# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys

def transpose(m):
    print("Transposé de ", m)
    if(len(m) < 2):
        print("Doit contenir au moins deux matrices.")
        print("Impossible d'appliquer l'opération de transposition.")
    else:
        try:
            for i in [[m[j][i] for j in range(len(m))] for i in range(len(m[0]))]:
                print(i)
        except IndexError:
            print("Chaque matrice doit possèder la même taille.")
            print("Impossible d'appliquer l'opération de transposition.")
    print("")

def main():
    i = [[1, 2], [4, 5], [8, 9]]
    j = [[1, 2, 4], [5, 8, 9]]
    k = [[1, 2, 3], [4, 5]]
    l = [[1]]
    
    transpose(i)
    transpose(j)
    transpose(k)
    transpose(l)

if __name__ == "__main__":
    main()
    #os.system("pause")
