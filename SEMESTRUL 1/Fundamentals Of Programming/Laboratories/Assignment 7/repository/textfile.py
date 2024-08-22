import os
import copy
import json

# from src.repository.repository import RepositoryError, Repository
from src.repository.memory_repository import RepositoryError, Memory
from src.domain.complex import *


class Text(Memory):

    def __init__(self, file_name) -> None:
        """
        init class for text repository
        :param file_name:
        """
        self.__file_name = file_name
        super().__init__()
        self.__load_file()

    def add_book(self, listof):
        """
        Add complex in list and saving in file
        :param listof:
        :return:
        """
        super().add_complex(listof)
        self.__save_file()

    def undo_list(self):
        """
        Undo last operation and saving in file
        :return:
        """
        super().undo_list()
        self.__save_file()

    def modify_list(self, new_list):
        """
        Modify list and saving in file
        """
        super().modify_list(new_list)
        self.__save_file()

    def __save_file(self):
        """
        Save file in text file folder
        :return:
        """
        self.File_object = open(self.__file_name, "w")
        strings = ''
        for each in self._history[-1]:
            strings += f"{each.real_part},{each.imaginary_part}\n"
        self.File_object.write(strings)
        self.File_object.close()

    def __load_file(self):
        """
        Load file from text file folder
        :return:
        """
        try:
            if os.path.getsize(self.__file_name) > 0:
                books = []
                line = ''
                with open(self.__file_name, "r") as file:
                    line = file.readlines()
                for each in line:
                    line_splited = each.split(",")
                    books.append([copy.deepcopy(line_splited[0].strip()), copy.deepcopy(line_splited[1].strip()),
                                  copy.deepcopy(line_splited[2].strip())])
                self._history.append([])
                for each in books:
                    self._history[-1].append(Complex(each[0], each[1], each[2]))
        except FileNotFoundError:
            raise RepositoryError("File not found.")
        except OSError:
            raise RepositoryError("Cannot start repository")