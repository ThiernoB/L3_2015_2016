#!/usr/bin/env python3
import sys

def palindrome(s):
	s = s.replace(" ", "")
	return s == (s[::-1])
	
print(palindrome(sys.argv[1]))
