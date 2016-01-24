#!/bin/bash

#TODO

FILE = "."


while read line; do
	echo $line
done < < ( cat $FILE )
