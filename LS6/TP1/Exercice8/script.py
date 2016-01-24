#!/usr/bin/env python3
import time

def convert(_time_):
    return time.strftime("%Hh:%Mm:%Ss", _time_)

def now():
	return time.localtime()

if __name__ == "__main__":
    while True:
        print(convert(now()))
        time.sleep(5)

