#!/usr/bin/env python3
import sys

def compte_espace(str):
	return str.count(" ", 0, len(str))
	
print(compte_espace(sys.argv[1]))
