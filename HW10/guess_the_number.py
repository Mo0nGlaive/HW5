import random

rnd = random.randint(0, 100)
#print(rnd)

guess = int(input("Guess the number: "))

for i in range(5):
    if i < 4:        
        if (guess > rnd):
            print("The number is below. Try again")
        elif (guess < rnd):
            print("The number is above. Try again")
        else:
            print("Congratulations! You guessed the right number.")
            break
    else:
        if (guess == rnd):
            print("Congratulations! You guessed the right number.")
            break
        else:
            print(f"Sorry, you've run out of attempts. The correct number was {rnd}")
            break
    guess = int(input("Guess the number: "))