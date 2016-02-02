# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys

def testset(l):
     return None

def testhachage(n, l):
     return None

def danstable(x, n, t):
    if len(t) == n:
        if t.count(x) > 0:
            return True

    return False

def ajoutertable(x, n, t):
    return None


def inittable(n):
    t = list()
    i = 0
    while i < n:
        t.append(None)
        i += 1
    return t

def main():
    print("TODO")

if __name__ == "__main__":
    main()
    #os.system("pause")
