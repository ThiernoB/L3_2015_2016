# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys

def inversion(str):
    str.reverse()
    return str

"""
def inversion(str):
    l = list()
    for s in str:
        l.append(s[::-1])
    return l
"""
def main():
    s = input()
    print(inversion(s.split()))
    

if __name__ == "__main__":
    main()
    #os.system("pause")
