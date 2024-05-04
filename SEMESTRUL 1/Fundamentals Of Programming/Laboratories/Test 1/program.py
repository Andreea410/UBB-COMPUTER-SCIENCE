# Ungur Andreea
# Functions section
#

import random
###generating the random number
def number_to_guess():
    """
    returns a random number of 4 distinct digits , that doesn't start with 0
    number gets random numbers untill one has all 4 digits distinct
    :return:int
    """
    number = random.randint(1000 , 9999)
    digits = number_digits(number)

    while is_valid(digits) == False or digits4(number) == False:
        number = random.randint(1000, 9999)
        digits = number_digits(number)

    return number


def number_digits(number : int):

    """
    return a frecquence list that represents if the digit appeared or not in the number
    :param number:int
    :return:list
    """

    digits = [0]*10
    while number:
        digits[number%10] = 1
        number //=10

    return digits

def is_valid(digits :list):
    """
    verifies if the input number correspond to the criteria of having 4 distinct digits
    returns true if is valid and false if is not
    :param digits:list
    :return:bool
    """

    sum_digits = sum(digits)
    if sum_digits == 4:
        return True
    else:
        return False

def runners_and_codes(guess:int , number:int , digits_number:list):
    """
    returns the codes and the runners for the guess , the user took
    codes -- the correct digits in the right position
    runners - the correct digits in the wrong position
    the function checks first if the digits are correct in the same position and if it isn t checks if the digits is in number
    but in a wrong position using strings
    :param guess:int
    :param number:int
    :param digits_number:list
    :return:int , int
    """

    runners = 0
    codes = 0
    c = number
    while guess:
        if guess%10 == c%10:  #checks if the digit is correct and in the correct position and if it is , it increases codes with 1
            codes += 1
        elif str(guess%10) in str(number): #checks if maybe the digit is correct but in a bad position , and verifies if it appears in number
            runners += 1
        guess //=10  #cuts the last digit of guess to check the one before this
        c//=10 #cuts the last digit of guess to check the one before this

    return runners , codes

def main():
    """
    solves the problem by analyzing every guess the user took
    :return: the solution
    """
    start_game()
    number = number_to_guess()
    digits_number = number_digits(number)

    while True:
        guess = user_guess()
        digits_guess = number_digits(guess)
        if guess == 8086:
            printing_number(number)
        elif is_valid(digits_guess) == False or digits4(guess) == False:
            game_lost(number)
            break

        else:
            runners , codes = runners_and_codes(guess , number , digits_number)
            if codes == 4:
                game_won()
                break
            else:
                printing_codes_runners(runners , codes)



def digits4(number):
    """
    checks if the number has exactly 4 digits and the first to be different from 0
    :param number:int
    :return:bool
    """

    if number < 1000 or number > 9999:
        return False
    return True

#
# User interface section
#

def printing_number(number):
    """
    prints the number the computer selected
    :param number:int
    :return:none
    """
    print(f"The number is {number}")

def printing_codes_runners(runners, codes):
    """
    informs the user how many codes and runners they have in the guess
    :param runners: int
    :param codes: int
    :return: none
    """

    print(f"Runners:{runners}")
    print(f"Codes:{codes}")


def game_won():
    """
    informs the user that they won
    :return: None
    """
    print("Congratulations , you won!")
def game_lost(number):
    """
    informs the user that they lost and prints the number they were supposed to guess
    :return: none
    """

    print("Game over.You lost.")
    print(f"The number you were supposed to guess was {number}")
def user_guess():
    """
    return the guess the user took
    :return:int
    """
    guess = int(input("Please enter your guess: "))
    return guess

def start_game():
    """

    :return:
    """
    print("Starting game...")
    print("Start guessing.")
    print("You are supossed to guess four digits numbers , with different digits and which don't start with 0")
    print("Codes represents correct digits in the correct position")
    print("Runners represent correct digits in the wrong position")



main()



