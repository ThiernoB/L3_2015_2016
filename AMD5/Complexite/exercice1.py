# -*-coding:Latin-1 -*
# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr

import os 
import time
import timeit
import random

def naive(val, arr):
	i = 0
	length = len(arr)
	find = False
	
	while i < length and find == False:
		if arr[i] == val:
			find = True
		i += 1
	return find

def dichot(val, arr):
	start = 0
	length = len(arr)
	find = False
	
	while find == False and start < length:
		mid = (start + length)//2
		if arr[mid] == val:
			find = True
		else:
			if val > arr[mid]:
				start = mid + 1
			else:
				length =  mid - 1
	
	return find

def wrapper(func, *args, **kwargs):
    def wrapped():
        return func(*args, **kwargs)
    return wrapped

	
my_file1 = open("naive.txt", "w")
my_file2 = open("dichotomie.txt", "w")

i = 0

while i < 300:
	length = i * 10 + 10
	array1 = [random.randint(-99999, 99999) for _ in range(length)]
	array1.sort()
	array2 = array1[:]
	value = random.randint(-100, 100)
	
	if length % 100 == 0:
		wrappe = wrapper(naive, value, array1)
		my_file1.write(str(length) + "\t" + str(timeit.timeit(wrappe, number=1000)) + "\n")
	
		wrappe = wrapper(dichot, value, array2)
		my_file2.write(str(length) + "\t" + str(timeit.timeit(wrappe, number=1000)) +"\n")
	i += 1
	
my_file1.close()
my_file2.close()

os.system("pause")