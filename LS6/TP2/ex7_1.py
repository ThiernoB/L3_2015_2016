# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys

def mails(f):
    for s in f.read().split(";"):
        if ("@" not in s) is False and ("etu" not in s) is False:
            print(s)

def main():
    f = open("inscrits.csv", "r")
    mails(f)
    f.close()

if __name__ == "__main__":
    main()
    #os.system("pause")
