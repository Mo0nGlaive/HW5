#!/bin/bash
number=$((RANDOM % 100 + 1))
for (( try=0; try<5; try++ ))
do
	read -p "Guess a number from 1 to 100: " guess
	let "result=guess-number"
	if (( try!=4 )); then
		if (( result>=10 )); then
			echo "The number is much lower!"
		fi
		if (( result<=-10 )); then
			echo "The number is much higher!"
		fi
		if (( result<10 && result>0 )); then
			echo "The number is a slightly lower"
		fi
		if (( result>-10 && result<0)); then
			echo "The number is a slightly higher"
		fi
		if (( result==0 )); then
			echo "Congratulations, you guessed the number!"
			break
		fi
	else
		if (( result==0 )); then
			echo "Congratulations, you guessed the number!"
			break
		else
			echo "Sorry, you are out of guesses. The correct number was $number"
		fi
	fi
done
