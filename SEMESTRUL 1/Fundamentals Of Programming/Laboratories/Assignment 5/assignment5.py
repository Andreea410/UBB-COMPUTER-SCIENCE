#
# Write the implementation for A5 in this file
#
import random


#
# Write below this comment
# Functions to deal with complex numbers -- list representation
# -> There should be no print or input statements in this section
# -> Each function should do one thing only
# -> Functions communicate using input parameters and their return values
#

# def create_list(number_complex_numbers :int):
#     #Creates a list of complex numbers introduced by the user
#     #number_complex_numbers -- int -- represents the number of elements the user wants to introduce into the list
#     #List_complex_numbers -- list -- here the elemnts will be introduced
#     #i -- int  -- index which counts the number of elements being introduced and makes sure that number_complex_number are introduced
#
#     list_complex_numbers = []
#
#     for i in range(number_complex_numbers):
#         real_part_complex_number, imaginary_part_complex_number = read_complex_number()
#         list_complex_numbers.append([real_part_complex_number, imaginary_part_complex_number])
#     return list_complex_numbers
#
# def get_real(i:int , list:list):
#     #returns the real part of the complex number
#     real = list[i]
#     real_part = real[0]
#     return real_part
#
#
# def get_imaginary(i: int, list: list):
#     #returns the imaginary part of the complex number
#
#     imaginary_part = list[i][1]
#     return imaginary_part

#
# Write below this comment
# Functions to deal with complex numbers -- dict representation
# -> There should be no print or input statements in this section
# -> Each function should do one thing only
# -> Functions communicate using input parameters and their return values
#

def create_general_dictionary():
    #Creates the dictionary for the complex number
    #It has two labels :real part - representing the real part of the complex number(a in case z=a+bi)
    #                   imaginary part - representing the imaginary part of the complex number(b in case z = a + bi)

    general_dictionary = {}
    real_part_complex_number, imaginary_part_complex_number = read_complex_number()
    general_dictionary = {"real_part": real_part_complex_number, "imaginary_part": imaginary_part_complex_number}
    return general_dictionary


def create_list(number_complex_numbers : int):
    #Creates a list using the function create_general_dictionary for creating the dictionaries
    list_complex_numbers = []
    for i in range(number_complex_numbers):
        general_dictionary = create_general_dictionary()
        list_complex_numbers.append(general_dictionary)
    return list_complex_numbers

def get_real(i:int , dictionary:list):
    #returns the real part of the complex number

    real_part = dictionary[i]["real_part"]
    return real_part

def get_imaginary(i: int, dictionary: list):
    #returns the imaginary part of the complex number

    imaginary_part = dictionary[int(i)]["imaginary_part"]
    return imaginary_part




#
# Write below this comment
# Functions that deal with subarray/subsequence properties
# -> There should be no print or input statements in this section
# -> Each function should do one thing only
# -> Functions communicate using input parameters and their return values
#

# def predefined_list():
#
#     list = []
#     list.append([1,2])
#     list.append([7, 4])
#     list.append([9, 3])
#     list.append([5, 3])
#     list.append([1, 7])
#     list.append([2, 10])
#     list.append([7, 2])
#     list.append([9, 3])
#     list.append([1, 2])
#     list.append([1, 6])
#
#     return list

def predefined_list():

    my_list = []
    my_list.append({"real_part": 7, "imaginary_part": 2})
    my_list.append({"real_part": 8, "imaginary_part": 9})
    my_list.append({"real_part": 2, "imaginary_part": 1})
    my_list.append({"real_part": 4, "imaginary_part": 2})
    my_list.append({"real_part": 5, "imaginary_part": 2})
    my_list.append({"real_part": 1, "imaginary_part": 3})
    my_list.append({"real_part": 1, "imaginary_part": 6})
    my_list.append({"real_part": 9, "imaginary_part": 5})
    my_list.append({"real_part": 10, "imaginary_part": 1})
    my_list.append({"real_part": 7, "imaginary_part": 2})
    return my_list


def calculation_modulus_complex_number(i : int, random_complex_number_list : list):
    #Calculates the modulus of the number with index i
    #return the modulus

    real_part = get_real(i ,random_complex_number_list)
    imaginary_part = get_imaginary(i ,random_complex_number_list)

    modulus = (real_part ** 2 + imaginary_part ** 2) ** 0.5
    return modulus


def solution_set_A(random_complex_number_list : list):
    #Gives the solution to set A
    #returns maximum length , index of first dictionary , index of last dictionary
    #length :int: the length of the current subarray
    #max_length: int : the current max_length of a subarray
    #index_first_element :int : the first element of current subarray
    # index_las_element :int: the last element of current subarray
    # modulus_first_complex :int: modulus first complex number
    # modulus_second _complex :int: modulus second complex number
    # max_length_first_index :int: index first element of the subarray with maximum length
    # max_length_last_index :int: index last element of the subarray with maximum length

    length = 1
    max_length = 1
    index_last_element = 0
    index_first_element = 0
    max_length_list = []
    modulus_first_complex = calculation_modulus_complex_number(0, random_complex_number_list)
    for i in range(len(random_complex_number_list) - 1):
        modulus_second_complex = calculation_modulus_complex_number(i + 1, random_complex_number_list)
        if modulus_first_complex < modulus_second_complex:
            length += 1
            index_last_element = i + 1
        else:
            if length > max_length:
                max_length = length
                max_length_first_index = index_first_element
                max_length_last_index = index_last_element
            length = 1
            index_first_element = i + 1

        modulus_first_complex = modulus_second_complex

    if length > max_length:
        max_length = length
        max_length_first_index = index_first_element
        max_length_last_index = index_last_element


    for i in range(max_length_first_index, max_length_last_index + 1):
        max_length_list.append(random_complex_number_list[i])

    return max_length, max_length_list


def solution_set_B(random_complex_number_list):
    #Gives the solution for set B
    #increasing :int: counts the increasing numbers
    #decreasing :int: counts the decreasing numbers
    #returns the length of the longest alternating series


    increasing = 1
    decreasing = 1
    modulus_first_complex = calculation_modulus_complex_number(0, random_complex_number_list)
    for i in range(1, len(random_complex_number_list)):
        modulus_second_complex = calculation_modulus_complex_number(i, random_complex_number_list)
        if modulus_first_complex < modulus_second_complex:
            decreasing = increasing + 1
        elif modulus_first_complex > modulus_second_complex:
            increasing = decreasing + 1
        modulus_first_complex = modulus_second_complex
    return max(increasing, decreasing)


#
# Write below this comment
# UI section
# Write all functions that have input or print statements here
# Ideally, this section should not contain any calculations relevant to program functionalities
#

def print_menu():
    #Prints the menu , the user will see and have to choose from

    print("1. Read a list of complex numbers (in `z = a + bi` form) from the console. a is named the real part and b the imaginary part")
    print("2. Display the entire list of numbers on the console.")
    print("3. Soltutions for the problems. ")
    print("4. Exit the application. ")


def choosing_option():
    #returns the option chose by the user
    # option = string
    option = input("Please choose an option from above: ")
    return option


def number_of_complex_numbers():
    #returns the number of complex numbers , the list should have
    #number_complex_numbers --int

    number_complex_numbers = int(input("Please enter the number of complex numbers you want to add to the list: "))
    return number_complex_numbers


def read_complex_number():
    #reads the complex number , separating it into real part and imaginary part
    # returns the real part and imaginary part
    # real_part_complex_number -- int
    # imaginary_part_complex_number -- int

    real_part_complex_number = int(input("Please enter the real part of the complex number: "))
    imaginary_part_complex_number = int(input("Please enter the imaginary part of the complex number: "))

    return real_part_complex_number, imaginary_part_complex_number


def menu_set_problems():
    #prints the menu for the two sets

    print("1. Solution for set A")
    print("2. Solution for set B")


def choosing_option_set_problems():
    # return the option chose by the user
    # return - int

    option = input("Please choose an option from above: ")
    return option


option = 0
list_complex_number = []
while option != 4:
    print_menu()
    option = choosing_option()

    if option == "1":
        number_complex_numbers = int(number_of_complex_numbers())
        list_complex_number = create_list(number_complex_numbers)

    elif option == "2":
        if list_complex_number == []:
            list_random = predefined_list()
            print(list_random)
        else:
            print(list_complex_number)

    elif option == "3":
        menu_set_problems()
        option_set_problems = choosing_option_set_problems()
        max_length_list = []

        if option_set_problems == "1":
            if list_complex_number == []:
                list = predefined_list()
            else:
                list = list_complex_number
            max_length, max_length_list = solution_set_A(list)
            print(max_length)
            print(max_length_list)

        elif option_set_problems == "2":
            if list_complex_number == []:
                list = predefined_list()
            else:
                list = list_complex_number
            print(list)
            length_longest_alternative = solution_set_B(list)
            print(f"The length of the longest alternative subsequence is {length_longest_alternative}")
        else:
            print("Invalid option.Please choose another option from the menu: ")
    elif option == "4":
        print("Exiting the application...")
        exit()
    else:
        print("Invalid option.Please choose another option from the menu: ")



