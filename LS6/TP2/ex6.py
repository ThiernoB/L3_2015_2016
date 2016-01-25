# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys


def main():
    f1 = open("vers-queneau.txt", "r")
    f2 = open("vers-queneau_copie.txt", "w")

    f2.write(f1.read().replace("e", ""))

    f1.close()
    f2.close()

if __name__ == "__main__":
    main()
    #os.system("pause")
