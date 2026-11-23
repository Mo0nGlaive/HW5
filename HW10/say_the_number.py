import random

rnd = random.randint(0, 100)
#print(rnd)
def user_input(i):
    if i < 1:
        guess = int(input("Say the number: "))
    else:
        guess = int(input("Now say it: "))
    return guess

for i in range(5):
    guess = user_input(i)
    if i < 4:        
        if (guess > rnd):
            print("You all know exactly the number. It's below.")
        elif (guess < rnd):
            print("You all know exactly the number. It's above.")
        else:
            print("You're goddamn right!")
            break#ingBad:)
    else:
        if (guess == rnd):
            print("You're goddamn right!")
            break#ingBad:)
        else:
            print(f"We won't do the project with you. The correct number was {rnd}")
            break#ingBad:)