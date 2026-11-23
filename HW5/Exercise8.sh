#!/bin/bash
fruits=("apple" "banana" "orange" "grape" "melon")

for (( i=0; i<${#fruits}; i++ ))
do
	echo ${fruits[i]}
done


