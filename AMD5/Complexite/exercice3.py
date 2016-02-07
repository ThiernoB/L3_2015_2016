# -*-coding:Latin-1 -*
# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr

import os 
import time
import random

MAX = 1000
MIN = -1 * MAX

def trieInsertion(arr):
	i = 1
	
	if arr is None:
		return None
		
	while i < len(arr):
		val = arr[i]
		j = i
		while j > 0 and arr[j - 1] > val:
			arr[j] = arr[j - 1]
			j -= 1
		arr[j] = val
		i += 1
	return arr

def fusion(t1, t2):
	if t1 == []:
		return t2
	if t2 == []:
		return t1
		
	if t1[0] < t2[0]:
		return [t1[0]] + fusion(t1[1 :],t2)
	else:
		return [t2[0]] + fusion(t1,t2[1 :])

def triFusion(arr):
	if arr is None:
		return None
		
	length = len(arr)
	mid = length // 2
	k = 0
	
	if length > 1:
		u = [arr[x] for x in range(mid)]
		v = [arr[x] for x in range(mid, length)]

		return fusion(triFusion(u), triFusion(v))
	else:
		return arr

my_file1 = open("trieInsertion.txt", "w")
my_file2 = open("triFusion.txt", "w")

i = 0

while i < 30:
	length = i * 10 + 10
	array1 = [random.randint(MIN, MAX) for _ in range(length)]
	array2 = array1[:]
	
	t1 = time.time()
	trieInsertion(array1)
	t2 = time.time() - t1
	my_file1.write(str(length) + "\t" + str(t2) + "\n")
	
	t1 = time.time()
	triFusion(array2)
	t2 = time.time() - t1
	my_file2.write(str(length) + "\t" + str(t2) + "\n")
	
	i += 1
	
my_file1.close()
my_file2.close()

os.system("pause")