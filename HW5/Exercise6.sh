#!/bin/bash
read -p "Enter sentence: " sentence

result=""

for word in $sentence
do
	result="$word $result"
done

echo "$result"
