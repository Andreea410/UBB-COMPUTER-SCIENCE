import copy

class RepositoryError(Exception):
    @property
    def message(self) -> str:
        """
        :return:
        """
        return self.__message

    def __init__(self, message: str = "Not specified Repository Error"):
        """
        init class for repository error
        :param message:
        """
        self.__message = message

    def __str__(self) -> str:
        """
        :return: str
        """
        return self.__message


class Memory:
    def __init__(self, filename="") -> None:
        """
        init class for memory repository
        :param filename:
        """
        self._history = [[]]

    def add_complex(self, dictionary: dict):
        """
        function for add a new complex number
        :param dictionary: dict
        :return:
        """
        new_list = copy.deepcopy(self._history[-1])
        new_list.append(dictionary)
        self._history.append(new_list)
        return self._history

    def complex(self):
        """
        function for get actual complex list
        :return: list
        """
        return self._history[-1]

    def undo_list(self):
        """
        Function for undo last operation
        :return: list
        """
        self._history.pop()
        return self._history

    def modify_list(self, new_list):
        """
        Function for adding a new list modified to history
        :param self:
        :param new_list: list
        :return: list
        """
        self._history.append(new_list)
        return self._history

    def length_of(self):
        """Length of actual list with history

        Returns:
            int: length of list
        """
        return len(self._history)

