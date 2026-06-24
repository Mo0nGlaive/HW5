import random

rnd = random.randint(0, 100)
#print(rnd)

guess = int(input("Say the number: "))

for i in range(5):
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
    guess = int(input("Now say it: "))