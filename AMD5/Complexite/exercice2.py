# -*-coding:Latin-1 -*
# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr

import os 
import time
import timeit
import random

MAX = 997

def somme(n):
	if n > 0:
		return n + somme(n - 1)
	else:
		return 0

def factorielle(n):
	if n > 0:
		return n * factorielle(n - 1)
	else:
		return 1
		

def mulMatrices(m1, m2):
	if len(m1[0]) == len(m2):
		return [[sum(e1*e2 for e1,e2 in zip(m1_row, m2_col)) for m2_col in zip(*m2)] for m1_row in m1]
	else:
		print("Nombre de lignes de la première matrice n'est pas égale au nombre de colonnes de la seconde.\nOpération Impossible.\n")
		return [[]]


def wrapper(func, *args, **kwargs):
    def wrapped():
        return func(*args, **kwargs)
    return wrapped
	
	
my_file1 = open("somme.txt", "w")
my_file2 = open("factorielle.txt", "w")
my_file3 = open("mulMatrices.txt", "w")

i = 0

while i < 10:
	length1 = i * 10 + 10
	length2 = i + 2
	array1 = [[random.randint(0, 10) for i in range(length2)] for j in range(length2)]
	array2 = [[random.randint(0, 10) for i in range(length2)] for j in range(length2)]
	
	wrappe = wrapper(somme, length1)
	my_file1.write(str(length1) + "\t" + str(timeit.timeit(wrappe, number=1000)) + "\n")
	
	wrappe = wrapper(factorielle, length1)
	my_file2.write(str(length1) + "\t" + str(timeit.timeit(wrappe, number=1000)) + "\n")
		
	wrappe = wrapper(mulMatrices, array1, array2)
	my_file3.write(str(length2) + "\t" + str(timeit.timeit(wrappe, number=1000)) + "\n")
	
	i +=1
	
my_file1.close()
my_file2.close()
my_file3.close()

os.system("pause")