# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys


def testset(l):
    s = set()
    n = len(l)
    
    for e in l:
        s.add(e)
    for e in l:
        
        print(e, " ", danstable(e, n, s))

def testhachage(n, l):
    t = inittable(n)

    for e in l:
        ajoutertable(e, n, t)
        print("ICI 2", t)
    
    for e in l:
        print(e, " ", danstable(e, n, t))

def danstable(x, n, t):
    if len(t) == n:
        if t.count(x) > 0:
            return True

    return False

def ajoutertable(x, n, t):
    if danstable(x, n, t) is False:
        if t.count(None) > 0:
            i = t.index(None)
            print("ICi", t, t[:i], t[i + 1:])
            t = t[:i] + t[i + 1:]
            print(t, x)
            t.insert(i, x)
            print(t)
        else:
            t.append(x)


def inittable(n):
    t = list()
    i = 0
    while i < n:
        t.append(None)
        i += 1
    return t



def main():
    l = list()
    TEST(1, l)
    print(l)

if __name__ == "__main__":
    main()
    #os.system("pause")
