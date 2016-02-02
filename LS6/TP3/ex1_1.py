# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys

def int_list(n):
    l = list()
    i = 1
    if n > i:
        while i <= n:
            l.append(i)
            i += 1
        return l 
    else:
        l.append(i)
        return l
        

def couples(i, j):
    return [(a, b) for a in int_list(i) for b in int_list(j)]

def main():
    try:
        i = int(sys.argv[1])
        j = int(sys.argv[2])
    except IndexError:  
        i = int(input("i = "))
        j = int(input("j = "))
    
    print([(a, b) for a in int_list(i) for b in int_list(j)])
    
if __name__ == "__main__":
    main()
    #os.system("pause")
