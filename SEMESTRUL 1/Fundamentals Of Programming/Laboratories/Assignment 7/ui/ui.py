
from src.services.requirements import *
import os


def __init__(self, rep, filename) -> None:
    self.rep = rep
    self.filename = filename
    self.complex = Requirements(self.rep, self.filename)
    pass


def test_for_add(self):
    self.complex.add_complex(1, 2)
    self.complex.add_complex(3 , 5)
    self.complex.add_complex(67 , 89)
    self.complex.add_complex(20 , 54)
    self.complex.add_complex(12 , 34)
    self.complex.add_complex(56 , 389)
    self.display_list_of_complex()
    self.logic.filter_list('maris')
    self.display_list_of_books()
    self.logic.undo_last_operation()
    self.display_list_of_books()


class UI:
    def __init__(self, rep, filename):
        self.__start = True
        self.__rep = rep
        self.__filename = filename
        self.__complex = Requirements(self.__rep, self.__filename)
        self.__checks = VerifyInput(self.__complex)
        if rep == "Memory":
            self.__add_values_at_start()

    def __add_values_at_start(self):
        self.__complex.add_complex(1 , 3)
        self.__complex.add_complex(45, 77)
        self.__complex.add_complex(34 , 65)
        self.__complex.add_complex(10 , 10)
        self.__complex.add_complex(3 , 9)
        self.__complex.add_complex(90 , 100)


    def print_menu(self):

        print("Complex numbers")
        print("1. Add a complex number")
        print("2. Display all complex numbers")
        print("3. Filter the list of complex numbers so that it contains only the numbers between indices start and end")
        print("4. Undo the last operation that modified program data")
        print("5. Exit")

    def start(self):
        while self.__start:
            self.print_menu()
            try:
                self.option()
            except ValueError as e:
                print(e)
    def option(self):

        option = input("Please choose an option: ").strip()
        if option not in ("1", "2", "3", "4"):
            raise ValueError("Invalid option!")
        self.proceed_option(option)

    def proceed_option(self, option):

        if option == "5":
            print("Now exiting...")
            self.__start = False

        elif option == "1":
            real_part = int(input("Please enter the real part of the complex number: "))
            imaginary_part = int(input("Please enter the imaginary part of the complex number: "))
            try:
                self.__complex.add_complex(real_part, imaginary_part)
            except ValueError as e:
                print(e)
        elif option == "2":
            try:
                self.__checks.verify_display()
                self.display_list_of_complex()
            except ValueError as e:
                print(e)
        elif option == "3":
            start = int(input("Please enter the start index: ")).strip()
            end = int(input("Please enter the end index: ")).strip()
            try:
                self.__checks.verify_filter(start, end)
                self.__complex.filter_list(start, end)
            except ValueError as e:
                print(e)
        elif option == "4":
            self.__undo()
            try:
                self.__checks.verify_undo()
                self.__complex.undo_last_operation()
            except ValueError as e:
                print(e)
    def display_list_of_complex(self):
        """
        Function for display list of complex numbers
        :return:
        """
        complex_list = self.__complex.get_complex_for_display()
        for number in complex_list:
            string = f'( {number.get_real_part} + {number.get_imaginary_part}i )'
            print(string)