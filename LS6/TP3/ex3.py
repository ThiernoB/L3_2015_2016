# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys
import time
import random

def testset(l):
     s = set()
     n = len(l)
     
     for v in l:
          s.add(v)

     for v in l:
           print(v, "est dans l'ensemble ?", (v in s))

     print(s)

def testhachage(n, l):
     t = inittable(n)
     
     for v in l:
          ajoutertable(v, n, t)

     print(t)
          
     for v in l:
           print(v, "est dans la table ?", danstable(v, n, t))
  

def danstable(x, n, t):
    if(len(t) == n):
        if(t.count(x) > 0):
            return True

    return False

def ajoutertable(x, n, t):
     i = 0
     if(len(t) == n):
          while i < n:
               if t[i] is None:
                    t[i] = x
                    return None
               i += 1
     else:
          return None

def inittable(n):
    t = list()
    i = 0
    while i < n:
        t.append(None)
        i += 1
    return t

def fill(n):
     l = list()
     for i in range(n):
          l.append(i + 1)
     return l

def testmethodes(k, m, n):
     l = [random.randint(0, m) for _ in range(k)]

     t1 = time.time()
     testhachage(n, l)
     t2 = time.time() - t1
     print("temps d'exécution de testhaschage", t2)

     t1 = time.time()
     testset(l)
     t2 = time.time() - t1
     print(t2)
     print("temps d'exécution de testset", t2)
     

def main():
     try:
          n = int(sys.argv[1])
          k = int(sys.argv[2])
          m = int(sys.argv[3])
     except IndexError:
          n = int(input("Taille de la table de hachage ?\n"))
          k = int(input("Taille de la liste d'entiers ?\n"))
          m = int(input("Entier maximum ?\n"))

     """    
     t = inittable(n)
     print(t)
     
     x = input("Entrez un élément dans la liste\n")
     ajoutertable(x, n, t)
     print(t)

     x = input("Entrez un élément dans la liste\n")
     ajoutertable(x, n, t)
     print(t)

     print(x, "est dans la table ?", danstable(x, n, t))
     x = "xD"
     print(x, "est dans la table ?", danstable(x, n, t))
     """
     #testhachage(n, fill(k))
     #testset(fill(k))
     testmethodes(k, m, n)

if __name__ == "__main__":
    main()
    #os.system("pause")
