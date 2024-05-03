#
# The program's functions are implemented here. There is no user interaction in this file, therefore no input/print statements. Functions here
# communicate via function parameters, the return statement and raising of exceptions.
#
def random_number_list():
    random_number_list = [{"real_part": "4", "imaginary_part": "2i", "sign": "+"},
                          {"real_part": "1", "imaginary_part": "1i", "sign": "+"},
                          {"real_part": "1", "imaginary_part": "1i", "sign": "-"},
                          {"real_part": "2", "imaginary_part": "0i", "sign": "+"},
                          {"real_part": "0", "imaginary_part": "1i", "sign": "+"},
                          {"real_part": "1", "imaginary_part": "3i", "sign": "+"},
                          {"real_part": "4", "imaginary_part": "1i", "sign": "+"},
                          {"real_part": "7", "imaginary_part": "0i", "sign": "+"},
                          {"real_part": "0", "imaginary_part": "5i", "sign": "+"},
                          {"real_part": "3", "imaginary_part": "4i", "sign": "+"}]
    return random_number_list
def function_dictionary():
    """
    This function is used to create a dictionary with the functions.
    :return: dictionary
    """
    function_dictionary = []
    function_dictionary = {"remove" : remove , "add" : add , "list" : list , "insert" : insert , "filter" : filter , "undo" : undo , "replace": replace }
    return function_dictionary

def get_number_for_add_and_insert(words):
    """
    This function is used to get the number from the command.
    :param words: list
    :return: list
    """

    number = words[1]
    return number


def separating_function(function):
    """
    This function is used to separate the command into words.
    :param function: str
    :return: list
    """
    if function:
        words = function.split()

    return words

def get_real(number):
    """
    This functions the real part of a complex number.
    :param number:
    :return:str
    """

    if len(number) == 1:
        real_part = number
    elif number[1] == "+":
        real_part = number.split("+")[0]
    elif number[1] == "-":
        real_part = number.split("-")[0]

    return real_part

def get_imaginary(number):
    """
    This function gets the imaginary part of a complex number.
    :param number:list
    :return:str
    """

    if len(number) == 1:
        imaginary_part = "0i"
    elif number[1] == "+":
        imaginary_part = number.split("+")[1]
    elif number[1] == "-":
        imaginary_part = number.split("-")[1]

    return imaginary_part


def get_sign(number):
    """
    This function gets the sign of a complex number.
    :param number: list
    :return: string
    """
    if len(number) == 1:
        sign = "0"
    elif number[1] == "+":
        sign = "+"
    elif number[1] == "-":
        sign = "-"

    return sign

def position_remove(words):
    """
    This function gets the position from the command.
    :param words: list
    :return: int
    """
    position = int(words[1])
    if position < 0:
        raise ValueError("Invalid position. Please try again.")

    return position

def position_insert(words):
    """
    This function gets the position from the command.
    :param words: list
    :return: int
    """
    position = int(words[3])
    return position

def modulo(dictionary):
    """
    This function returns the modulo of a complex number.
    :param dictionary:dictionary
    :return: int
    """

    real_part = int(dictionary["real_part"])
    imaginary_part = dictionary["imaginary_part"]
    imaginary_part = int(imaginary_part.strip("i"))
    modulo = (real_part ** 2 + imaginary_part ** 2) ** (1/2)
    return modulo

def dictionary(number):
    """
    This function is used to create a dictionary with the real part, imaginary part and sign of a complex number.
    :param number:
    :return:
    """
    real_part = get_real(number)
    imaginary_part = get_imaginary(number)
    sign = get_sign(number)
    dictionary = {"real_part": real_part , "imaginary_part": imaginary_part , "sign": sign}
    return dictionary

def add(numbers_list , words):
    """
    This function is used to add a complex number to the list.
    :param numbers_list: list
    :param words:list
    :return:list
    """

    number = get_number_for_add_and_insert(words)
    if not number:
        raise ValueError("Invalid command.")
    dict = dictionary(number)
    if not dict:
        raise ValueError("Invalid command.")
    numbers_list.append(dict)
    return numbers_list


def undo(history_list):
    """

    :param history_list:
    :return:
    """
    if len(history_list) > 1:
        history_list.pop()
        return history_list[-1]
    else:
        print("Cannot undo further. History is empty.")


def insert(numbers_list, words):
    try:
        number = get_number_for_add_and_insert(words)
        position = position_insert(words)


        if 0 <= position <= len(numbers_list):
            dict = dictionary(number)


            if position == len(numbers_list):
                numbers_list.append(dict)
            else:
                numbers_list.insert(position, dict)

            print(numbers_list)
            return numbers_list
        else:
            print("Invalid position. Please try again.")
            return numbers_list

    except ValueError:
        print("Invalid position. Please try again.")
        return numbers_list


def remove(numbers_list, words):
    try:
        if len(words) == 2:
            position = position_remove(words)
            if position is not None and position < len(numbers_list) and position >= 0:
                numbers_list.pop(position)
                print(numbers_list)
                return numbers_list
            else:
                raise ValueError("There aren`t enough numbers. Please try again.")
        elif len(words) == 4:
            if words[2] == "to":
                start_position = int(words[1])
                end_position = int(words[3])
                while end_position >= start_position and end_position < len(numbers_list) and start_position >= 0:
                    numbers_list.pop(start_position)
                    end_position = end_position - 1
            print(numbers_list)
            return numbers_list
        else:
            raise ValueError("Invalid command. Please try again.")


    except ValueError:
        raise ValueError("Invalid command. Please try again.")


def replace(numbers_list, words):
    """
    This function is used to replace a number from the list.
    :param numbers_list:list
    :param words:list
    :return:list
    """
    first_number = words[1]
    dictionary_first_number = dictionary(first_number)
    second_number = words[3]
    dictionary_second_number = dictionary(second_number)
    for i in range(len(numbers_list)):
        if numbers_list[i] == dictionary_first_number:
            numbers_list[i] = dictionary_second_number
    print(numbers_list)
    return numbers_list


def list(numbers_list, words):
    """
    This function is used to replace a number from the list.
    :param numbers_list:list
    :param words:list
    :return:list
    """

    if len(words) == 1:
        print(numbers_list)

    elif len(words) == 5:
        start_position = int(words[2])
        end_position = int(words[4])
        for i in range(start_position, end_position + 1):
            if numbers_list[i]["imaginary_part"] == "0i":
                print(numbers_list[i])

    elif len(words) == 4:
        if words[2] == "<":
            number = int(words[3])
            for i in range(len(numbers_list)):
                if modulo(numbers_list[i]) < number:
                    print(numbers_list[i])
        elif words[2] == "=":
            number = int(words[3])
            for i in range(len(numbers_list)):
                if modulo(numbers_list[i]) == number:
                    print(numbers_list[i])

        elif words[2] == ">":
            number = int(words[3])
            for i in range(len(numbers_list)):
                if modulo(numbers_list[i]) > number:
                    print(numbers_list[i])

    return numbers_list

def filter(numbers_list, words):
    """
    This function is used to filter the list.
    :param numbers_list: list
    :param words: list
    :return: list
    """
    filtered_list = []
    if words[1] == "real":
        for i in range(len(numbers_list)):
            if numbers_list[i]["imaginary_part"] == "0i":
                filtered_list.append(numbers_list[i])
    elif words[1] == "modulo":
        if words[2] == "<":
            number = int(words[3])
            for i in range(len(numbers_list)):
                if modulo(numbers_list[i]) < number:
                    filtered_list.append(numbers_list[i])
        elif words[2] == "=":
            number = int(words[3])
            for i in range(len(numbers_list)):
                if modulo(numbers_list[i]) != number:
                    filtered_list.append(numbers_list[i])
        elif words[2] == ">":
            number = int(words[3])
            for i in range(len(numbers_list)):
                if modulo(numbers_list[i]) > number:
                    filtered_list.append(numbers_list[i])

    numbers_list = filtered_list
    print(numbers_list)
    return numbers_list



def test_add():
    from ui import add

    numbers_list = []
    words = ["add", "4+2i"]
    add(numbers_list, words)
    assert numbers_list == [{"real_part": "4", "imaginary_part": "2i", "sign": "+"}]

    words = ["add", "1+1i"]
    add(numbers_list, words)
    expected_result = [
        {"real_part": "4", "imaginary_part": "2i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "1i", "sign": "+"}
    ]
    assert numbers_list == expected_result

    words = ["add", "1-1i"]
    add(numbers_list, words)
    expected_result = [
        {"real_part": "4", "imaginary_part": "2i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "1i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "1i", "sign": "-"}
    ]
    assert numbers_list == expected_result

    words = ["add", "1+0i"]
    add(numbers_list, words)
    expected_result = [
        {"real_part": "4", "imaginary_part": "2i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "1i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "1i", "sign": "-"},
        {"real_part": "1", "imaginary_part": "0i", "sign": "+"}
    ]
    assert numbers_list == expected_result

    words = ["add", "0+1i"]
    add(numbers_list, words)
    expected_result = [
        {"real_part": "4", "imaginary_part": "2i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "1i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "1i", "sign": "-"},
        {"real_part": "1", "imaginary_part": "0i", "sign": "+"},
        {"real_part": "0", "imaginary_part": "1i", "sign": "+"}
    ]
    assert numbers_list == expected_result

def test_remove():
    from ui import remove

    numbers_list = [
        {"real_part": "4", "imaginary_part": "2i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "i", "sign": "+"}
    ]
    words = ["remove", "1"]
    remove(numbers_list, words)
    expected_result = [{"real_part": "4", "imaginary_part": "2i", "sign": "+"}]
    assert numbers_list == expected_result


    words = ["remove", "0", "to", "0"]
    remove(numbers_list, words)
    assert numbers_list == []


    numbers_list = [
        {"real_part": "4", "imaginary_part": "2i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "i", "sign": "+"}
    ]
    words = ["remove", "0", "to", "1"]
    remove(numbers_list, words)
    assert numbers_list == []

    numbers_list = [
        {"real_part": "4", "imaginary_part": "2i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "i", "sign": "+"}
    ]
    words = ["remove", "0", "to", "1"]
    remove(numbers_list, words)
    assert numbers_list == []

    numbers_list = [
        {"real_part": "4", "imaginary_part": "2i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "i", "sign": "+"}
    ]
    words = ["remove", "0"]
    remove(numbers_list, words)
    expected_result = [{"real_part": "1", "imaginary_part": "i", "sign": "+"}]

def test_insert():
    from ui import insert

    numbers_list = []
    words = ["insert", "1+i", "at", "0"]
    insert(numbers_list, words)
    expected_result = [{"real_part": "1", "imaginary_part": "i", "sign": "+"}]
    assert numbers_list == expected_result

    words = ["insert", "2+2i", "at", "0"]
    insert(numbers_list, words)
    expected_result = [
        {"real_part": "2", "imaginary_part": "2i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "i", "sign": "+"}
    ]
    assert numbers_list == expected_result

    words = ["insert", "3+3i", "at", "0"]
    insert(numbers_list, words)
    expected_result = [
        {"real_part": "3", "imaginary_part": "3i", "sign": "+"},
        {"real_part": "2", "imaginary_part": "2i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "i", "sign": "+"}
    ]
    assert numbers_list == expected_result

    words = ["insert", "4+4i", "at", "1"]
    insert(numbers_list, words)
    expected_result = [
        {"real_part": "3", "imaginary_part": "3i", "sign": "+"},
        {"real_part": "4", "imaginary_part": "4i", "sign": "+"},
        {"real_part": "2", "imaginary_part": "2i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "i", "sign": "+"}
    ]
    assert numbers_list == expected_result

    words = ["insert", "5+5i", "at", "2"]
    insert(numbers_list, words)
    expected_result = [
        {"real_part": "3", "imaginary_part": "3i", "sign": "+"},
        {"real_part": "4", "imaginary_part": "4i", "sign": "+"},
        {"real_part": "5", "imaginary_part": "5i", "sign": "+"},
        {"real_part": "2", "imaginary_part": "2i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "i", "sign": "+"}
    ]
    assert numbers_list == expected_result

    words = ["insert", "6+6i", "at", "3"]
    insert(numbers_list, words)
    expected_result = [
        {"real_part": "3", "imaginary_part": "3i", "sign": "+"},
        {"real_part": "4", "imaginary_part": "4i", "sign": "+"},
        {"real_part": "5", "imaginary_part": "5i", "sign": "+"},
        {"real_part": "6", "imaginary_part": "6i", "sign": "+"},
        {"real_part": "2", "imaginary_part": "2i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "i", "sign": "+"}
    ]
    assert numbers_list == expected_result

    words = ["insert", "7+7i", "at", "4"]
    insert(numbers_list, words)
    expected_result = [
        {"real_part": "3", "imaginary_part": "3i", "sign": "+"},
        {"real_part": "4", "imaginary_part": "4i", "sign": "+"},
        {"real_part": "5", "imaginary_part": "5i", "sign": "+"},
        {"real_part": "6", "imaginary_part": "6i", "sign": "+"},
        {"real_part": "7", "imaginary_part": "7i", "sign": "+"},
        {"real_part": "2", "imaginary_part": "2i", "sign": "+"},
        {"real_part": "1", "imaginary_part": "i", "sign": "+"}
    ]
    assert numbers_list == expected_result
