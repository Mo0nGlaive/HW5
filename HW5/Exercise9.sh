#!/bin/bash
filename=$1

if [ ! -e "$filename" ]; then
	echo "$filename doesn't exist"
	exit 1
fi

if [ -d "$filename" ]; then
	echo "Can not read $filename, it is directory"
	exit 1
fi

if [ -f "$filename" ]; then
	cat "$filename"
fi
