# -*-coding:Latin-1 -*
# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr

import os 
import time
import random

def suppressionOccurence(E):
	for i in E:
		while E.count(i) > 1:
			E.remove(i)
	return E
	
def plusGrandElement(E, S):
	if E == None or len(E) == 0:
		return None
	
	tmp = E[:]
	
	if S == None:
		return tmp.pop()
	else:
		for i in S:
			if tmp.count(i) > 0:
				tmp.remove(i)
		return tmp.pop()
		
def algo(E):
	S = []
	P = [[]]
	ele = None
	tmp = None
	
	print("E = ", E)
	
	while P[len(P) - 1] != E:
		tmp = E[:]
		
		for i in S:
			tmp.remove(i)
	
		ele = tmp.pop()
	
		for k in S[:]:
			if k > ele:
				S.remove(k)
				
		S.append(ele)
		P.append(S[:])
		
	print("P = ", P)

def main():
	E = None
	
	value = input("Saisissez la taille de votre ensenble d'entiers positif : ")
	value = int(value)

	E = list(range(value))
	
	t1 = time.time()
	algo(E)
	t2 = time.time() - t1
	print(t2)

main()


os.system("pause")