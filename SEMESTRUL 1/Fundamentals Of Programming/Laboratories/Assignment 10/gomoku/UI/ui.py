import random
from gomoku.domain.check import Captured , Win
from gomoku.domain.coordonates import Coordonates
from gomoku.services.service import Service
from gomoku.domain.board import Board
from gomoku.utilities.main import *
from gomoku.domain.moves import *
class UserInterface:

    def __init__(self):

        self.board =[]
        for x in range(15):
            row = [0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0]
            self.board.append(row)
        self.service = Service()
        self.win_check = Win()
        self.captured_check = Captured()
        self.white_score = 0
        self.black_score = 0



    def get_player_data(self):
        """
        This function gets the info about the stone from the player
        :return: int , int
        """

        print("The rows and colums are numbered from 0 to 14")
        x_pos = int(input("Please enter the row you want to place your stone: "))
        y_pos = int(input("Please enter the column you want to place your stone: "))
        return x_pos , y_pos

    def player_turn(self , order):

        """
        This function executes the player s turn and updates the board
        :param order: bool
        :return: bool
        """
        x_pos , y_pos = self.get_player_data()
        service_response = self.service.verifiy_if_int(x_pos , y_pos)
        if service_response["succes"] == False:
            print(service_response["message"])
            return order
        else:
            service_response = self.service.verify_if_on_board(x_pos , y_pos)
            if service_response["succes"] == False:
                print(service_response["message"])
                return order
            else:
                service_response = self.service.verify_if_move_is_valid(x_pos , y_pos , self.board)
                if service_response["succes"] == False:
                    print(service_response["message"])
                    return order
                else:
                    print(service_response["message"])
                    self.update_board(x_pos , y_pos , 1)
                    order = False
                    return order

    def update_board(self , x_pos , y_pos , player):
        """
        This function updates the board
        :param x_pos: int
        :param y_pos: int
        :param player: int
        :return: None
        """
        self.board[x_pos][y_pos] = player

    def get_computer_data(self):
        """
        This function gets the info about the stone from the computer
        :return: int , int
        """
        x_pos = random.randint(0 , 14)
        y_pos = random.randint(0 , 14)
        return x_pos , y_pos
    def computer_turn(self, order):
        """
        This function executes the computer s turn and updates the board
        :param order: bool
        :return: bool
        """

        x_pos , y_pos  = self.win_check.calcultate_best_move(self.board)
        if x_pos ==None:
            x_pos , y_pos = self.get_computer_data()
        service_response = self.service.verify_if_move_is_valid(x_pos , y_pos , self.board)
        if service_response["succes"] == True:
            self.update_board(x_pos , y_pos , -1)
            order = True
            print(f"The computer placed a stone on row {x_pos} and column {y_pos}")
            print("The computer s turn is over")
        return order

    def print_board(self):
        """
        This function prints the board
        :return:
        """
        for row in self.board:
            for column in row:
                print(column , end = " ")
            endline = "\n"
            print(" " , end = endline)

    def play(self):
        """
        This function starts the game
        :return:
        """
        print("Welcome to Gomoku!You are playing with the white stones marked with 1 "
              "and the computer is playing with the black stones marked with -1.")
        order = True
        while True:
            self.board,self.white_score,self.black_score= self.captured_check.verify_board(self.board , self.white_score , self.black_score)
            self.print_board()
            if order == True:
                order = self.player_turn(order)
                if self.win_check.win_check(1 , self.board) == True:
                    print("You won!")
                    break
            else:
                order = self.computer_turn(order)
                if self.win_check.win_check(-1 , self.board) == True:
                    print("You lost!")
                    break

