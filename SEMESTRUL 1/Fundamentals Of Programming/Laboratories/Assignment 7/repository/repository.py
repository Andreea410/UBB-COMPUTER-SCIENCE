import copy

class Repository:

    def __init__(self):
        """
        init class for memory repository
        """
        self.__history = [[]]

    def add_complex(self, dictionary: dict):
        """
        function for add a new book
        :param: dict
        :return: list
        """
        new_list = copy.deepcopy(self.__history[-1])
        new_list.append(dictionary)
        self.__history.append(new_list)
        return self.__history

    def get_complex(self):
        """
        function for get actual complex list
        :return:
        """
        return self.__history[-1]

    def undo_list(self):
        """
        Function for undo last operation
        :param self:
        :return: list
        """
        self._history.pop()
        return self.__history

    def add_to_history(self, new_list):
        """
        Function for adding a new list modified to history
        :param self:
        :param new_list: list
        :return: list
        """
        self.__history.append(new_list)
        return self.__history

    def length_of(self):
        """Length of actual list with history

        Returns:
            int: length of list
        """
        return len(self._data)
