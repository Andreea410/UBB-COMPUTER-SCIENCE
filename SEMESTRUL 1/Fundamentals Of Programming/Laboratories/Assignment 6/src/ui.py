#
# This is the program's UI module. The user interface and all interaction with the user (print and input statements) are found here
#

from functions import *
import copy

def menu():
    """
    This function is used to print the menu.
    :return:
    """

    print("(A) Add a number")
    print("\tadd <number>")
    print("\tinsert <number> at <position>")
    print("e.g.")
    print("\tadd 4+2i – appends 4+2i to the list")
    print("\tinsert 1+1i at 1 – insert number 1+i at position 1 in the list (positions are numbered starting from 0)")
    print("(B) Modify numbers")
    print("\tremove <position>")
    print("\tremove <start position> to <end position>")
    print("\treplace <old number> with <new number>")
    print("e.g.")
    print("\tremove 1 – removes the number at position 1")
    print("\tremove 1 to 3 – removes the numbers at positions 1,2, and 3")
    print("\treplace 1+3i with 5-3i – replaces all occurrences of number 1+3i with the number 5-3i")
    print("(C) Display numbers having different properties")
    print("\tlist")
    print("\tlist real <start position> to <end position>")
    print("\tlist modulo [ < | = | > ] <number>")
    print("e.g")
    print("\tlist – display all numbers")
    print("\tlist real 1 to 5 – display the real numbers (imaginary part =0) between positions 1 and 5")
    print("\tlist modulo < 10 – display all numbers with modulo <10")
    print("\tlist modulo = 5 – display all numbers with modulo =5")
    print("(D) Filter the list")
    print("\tfilter real")
    print("\tfilter modulo [ < | = | > ] <number>")
    print("e.g")
    print("\tfilter real – keep only numbers having imaginary part =0")
    print("\tfilter modulo < 10 – keep only numbers having modulo <10")
    print("\tfilter modulo > 6 – keep only those numbers having modulo >6")
    print("(E) Undo")
    print("\tundo – the last operation that modified program data is reversed. The user can undo all operations performed since program start by repeatedly calling this function.")
    print("(F) Exit")
    print("(G) Help for printing the menu")
def user_function():
    """
    This function is used to read the user's input.
    :return: string
    """
    function = input("Please enter the FUNCTION you want to execute: ")
    return function

###FUNCTTIONS FOR THE COMMANDS########

def main():
    """
    This function is used to start the program.
    :return:
    """

    menu()
    numbers_list = random_number_list()
    history_list = []

    while True:
        function = user_function()
        words = separating_function(function)
        function_name = words[0].lower()

        functions = function_dictionary()
        try:
            if function_name == "add":
                if numbers_list!=random_number_list():
                    numbers_list = add(numbers_list, words)
                    history_list.append(copy.deepcopy(numbers_list))
                elif numbers_list == random_number_list():
                    numbers_list = []
                    numbers_list = add(numbers_list, words)
                    if numbers_list == []:
                        numbers_list = random_number_list()
                    history_list.append(copy.deepcopy(numbers_list))
                print(numbers_list)


            elif function_name in functions:
                if function_name == "undo":
                    numbers_list = undo(history_list)
                    print(numbers_list)

                else:
                    numbers_list = functions[function_name](numbers_list, words)
                    history_list.append(copy.deepcopy(numbers_list))
            elif function_name == "exit":
                break
            elif function_name == "help":
                menu()
            else:
                print("Invalid command.")
        except ValueError as ve:
            print(ve)

