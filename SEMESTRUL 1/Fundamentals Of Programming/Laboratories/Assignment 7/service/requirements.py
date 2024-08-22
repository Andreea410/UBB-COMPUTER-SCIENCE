from src.domain.complex import Complex
from src.repository.memory_repository import Memory
from src.repository.repository import Repository
import sys


class Requirements:

    def __init__(self, rep, filename):
        """
        :param rep: repository
        :param filename: filename
        """
        self.rep = getattr(sys.modules[__name__], rep)(filename)

    def add_complex(self, real_part, imaginary_part):
        """
        :param real_part: int
        :param imaginary_part: int
        :return:
        """
        self.rep.add_complex(Complex(real_part, imaginary_part))

    def filter_list(self, start, end):
        """
        Filter list of complex numbers so that it contains only the numbers between indices start and end
        :param start: int
        :param end: int
        """

        complex_list = self.rep.get_complex()
        for i in range(start, end + 1):
            complex_list.pop(i)

        return complex_list

    def undo_last_operation(self):
        """Undo last operation
        """
        self.rep.undo_list()

    def get_complex_for_display(self):
        """Return list of complex numbers for display in UI
        Returns:
            list: list of complex numbers
        """
        return self.rep.get_complex()


class VerifyInput:

    def __init__(self, complex_service) -> None:
        """
        init class for verify input
        :param complex_service: class
        """
        self.complex_service = complex_service

    def verify_display(self):
        """
        Verify if list is empty
        :return:
        """
        complex_list = self.complex_service.get_complex_for_display()
        if len(complex_list) == 0:
            raise ValueError("List is empty. You can use add or undo.")

    def verify_filter(self, input_title):
        """
        Verify if list is empty
        :param input_title:
        :return:
        """
        complex_list = self.complex_service.get_complex_for_display()
        if len(complex_list) == 0:
            raise ValueError("List is empty. You can use only Add command.")

    def verify_undo(self):
        """
        Verify if list is empty
        :return:
        """
        complex_list_length = self.complex_service.get_complex_length()
        if complex_list_length == 1:
            raise ValueError("List is empty. You can use only Add command.")

    def get_complex_for_display(self):
        """Return list of complex numbers for display in UI
        Returns:
            list: list of complex numbers
        """
        return self.rep.complex()

