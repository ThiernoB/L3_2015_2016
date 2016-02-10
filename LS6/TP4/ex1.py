# -*-coding:Latin-1 -*
#!/usr/bin/env python3

# @author Pierre Dibo
# @email rgv26.warforce@hotmail.fr
import os
import sys

def listeversdico(l):
    keys = fill(len(l))
    values = l
    return { keys[i] : values[i] for i in range(len(keys)) }

def mergedico(d1, d2):
    d = d1.copy()
    d.update(d2)
    return d

def chars(w):
    s = set()
    l = list()
    for v in w:
        s.add(v)
        
    s = sorted(s)

    for v in s:
        l.append(w.count(v, 0, len(w)))

    keys = s
    values = l
    
    return { keys[i] : values[i] for i in range(len(keys)) }

def affichedico(d):
    for (k, v) in sorted(d.items()):
        print(k, v)

def merge(d1, d2):
    return dict_intersect(d1, d2)

def fill(n):
    l = list()
    for i in range(n):
        l.append(i + 1)
    return l

#http://stackoverflow.com/questions/
#18554012/intersecting-two-dictionaries-in-python
def dict_intersect(*dicts):
    comm_keys = dicts[0].keys()
    for d in dicts[1:]:
        # intersect keys first
        comm_keys &= d.keys()
    # then build a result dict with nested comprehension
    result = {key:{d[key] for d in dicts} for key in comm_keys}
    return result
    
def main():
    print(listeversdico(["petit","klein","small"]))
    
    d1, d2 = {1:2,2:3}, {1:4,4:4} 
    print(mergedico(d1, d2))

    affichedico(chars("aacababbccd"))
    
    d1 = {"r":0.56, "t":0.78, "i":0.23, "u":0.35}
    d2 = {"i":5, "v":89, "p": 65, "t":21, "b":55}
    print(merge(d1, d2))

if __name__ == "__main__":
    main()
    #os.system("pause")
