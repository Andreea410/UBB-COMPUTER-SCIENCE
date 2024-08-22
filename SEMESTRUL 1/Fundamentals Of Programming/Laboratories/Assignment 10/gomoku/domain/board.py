from texttable import Texttable
class GomokuError(Exception):

    def __init__(self, message: str):
        self.__message = message

    def message(self):
        return self.__message

    def __str__(self):
        return self.__message
class Board:

    def __init__(self, width: int, height: int):
        self.__width = width
        self.__height = height
        self.__board = [[' ' for _ in range(width)] for _ in range(height)]

    @property
    def width(self):
        return self.__width

    @property
    def height(self):
        return self.__height

    def __str__(self):
        t = Texttable()
        hrow = ['/']
        for i in range(self.__width):
            hrow.append(chr(ord('A') + i))
        t.header(hrow)

        for i in range(self.__height):
            t.add_row([i + 1] + self.__board[i])

        return t.draw()

    def move(self, symbol, row: int, column: int):
        if not (0 <= row < self.__height):
            raise GomokuError("Invalid row")
        if not (0 <= column < self.__width):
            raise GomokuError("Invalid column")
        if self.__board[row][column] != ' ':
            raise GomokuError("Place already taken")
        # place the symbol
        self.__board[row][column] = symbol

    @property
    def get_square(self, row: int, column: int):
        if not (0 <= row < self.__height):
            raise GomokuError("Invalid row")
        if not (0 <= column < self.__width):
            raise GomokuError("Invalid column")
        return self.__board[row][column]

