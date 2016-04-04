# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr

import os
import sys

def isJPG(file):
    if "jpg" in file or "jpeg" in file or "JPG" in file or "JPEG" in file:
        return True
    else:
        return False

def list_jpeg(rep):
    if rep is None:
        rep = '.'
    for dossier, sous_dossiers, fichiers in os.walk(rep):
        for file in fichiers:
            if isJPG(file):
                print(file)
        break

def list_jpeg_r(rep):
    if rep is None:
        rep = '.'
    for dossier, sous_dossiers, fichiers in os.walk(rep):
        for file in fichiers:
            if isJPG(file):
                print(os.path.abspath(file))
            
def main():
    print("Exercice 1 tp8\n")
    """
    try:
        rep = sys.argv[1]
    except IndexError:
        rep = input("Dossier\n")
    """    
    list_jpeg('.\Arbo\Photos')
    #list_jpeg_r('.\Arbo\Photos')

if __name__ == "__main__":
    main()
    #os.system("pause")
