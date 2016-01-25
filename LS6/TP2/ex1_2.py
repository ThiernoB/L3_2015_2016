# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys

def inversion(str):
    s = ""
    str.reverse()
    for v in str:
        s = s + v
        s = s + " "
    return s

def main():
    s = input()
    print(inversion(s.split()))
    

if __name__ == "__main__":
    main()
    #os.system("pause")
