#!/usr/bin/env python3
import sys

def sans_e(str):
	return str.replace("e", "")
	
print(sans_e(sys.argv[1]))
