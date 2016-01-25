# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys

def diviseurs(n):
    l = list()
    i = 1

    while i <= n:
        if(n % i == 0):
            l.append(i)
        i += 1
    print(l)
    return l

def nombre_premier(n):
    l = list()
    i = 1

    while i <= n:
        if(i <= 2):
            l.append(i)       
        else:
            iterator = 2
            while iterator <= i:
                if(i % iterator == 0):
                    break
                iterator += 1
            if(iterator == i):
                l.append(i)
        i += 1
    
    print(l)
    return l

def main():
    try:
        n = int(sys.argv[1])
    except IndexError:
        n = int(input("Entier n :\n"))

    l = diviseurs(n)
    nombre_premier(n)

if __name__ == "__main__":
    main()
    #os.system("pause")
