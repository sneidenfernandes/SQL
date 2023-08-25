import random 

def has_duplicates(birthdays): #Checks if the list of birthdays has duplicates
    return len(birthdays) != len(set(birthdays))


def birthday_paradox_simulation(sampleSize,num_simulations):
    duplicates = 0

    for i in range(num_simulations):

        birthdays = [random.randint(1,365) for i in range(sampleSize)]
        if has_duplicates(birthdays):
            duplicates += 1

    probability = duplicates/num_simulations
    return probability 


def main():
    sampleSize = 23 # Sample size of people in the room
    num_simulations = 1000000000000 #Number of Simulations

    probability = birthday_paradox_simulation(sampleSize,num_simulations)

    print(f"""

Results:
          Sample Size: {sampleSize}
          Number of Simulations: {num_simulations}
          P(Duplicate Birthdays): {probability}
""")

if __name__ == '__main__':
    main()

