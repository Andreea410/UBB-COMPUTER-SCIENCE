import pickle
import copy
import os
# from src.repository.repository import RepositoryError, Repository
from src.repository.memory_repository import RepositoryError, Memory


class MemoryPickle(Memory):

    def __init__(self, file_name) -> None:
        """
        init class for pickle repository
        :param file_name: str
        """

        self.__file_name = file_name
        super().__init__()
        self.__load_file()

    def add_complex(self, list, dict):
        """
        Function for add a new complex number
        :param list: list
        :return:
        """

        super().add_complex(list, dict)
        self.__save_file()

    def undo_list(self):
        """
        Function for undo last operation
        :return:
        """
        super().undo_list()
        self.__save_file()

    def __save_file(self):
        """
        Function for save file
        :return:
        """
        file = open(self.__file_name, "wb")
        pickle.dump(self._data, file)
        file.close()

    def __load_file(self):
        """
        Function to load file
        :return:
        """
        try:
            if os.path.getsize(self.__file_name) > 0:
                file = open(self.__file_name, "rb")
                self._data = pickle.load(file)
                file.close()
        except FileNotFoundError:
            raise RepositoryError("File not found.")
        except OSError:
            raise RepositoryError("Cannot start repository")

    def modify_list(self, new_list):
        """
        Function for modify list
        :param self:
        :param new_list:
        :return:
        """
        super().modify_list(new_list)
        self.__save_file()
