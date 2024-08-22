import pygame
from gomoku.utilities.main import *
import sys
import random
from gomoku.domain.moves import Move
from gomoku.domain.check import Captured , Win
from gomoku.services.service import Service

class GraphicalUserInterface:

    def __init__(self):
        pygame.init()
        self.player_order = True
        self.board =[]
        self.moves = Move()
        self.capture = Captured()
        self.check = Win()
        self.service = Service()
        self.white_score = 0
        self.black_score = 0
        for x in range(15):
            row = [0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0]
            self.board.append(row)
        self.start_window = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
        self._start_window()

    def background(self , window , image):
        """
        This function sets the background
        :param window:
        :param image:
        :return:
        """
        size = pygame.transform.scale(image,(SCREEN_WIDTH , SCREEN_HEIGHT))
        window.blit(size,(0,0))

    def draw_gomoku_table(self):
        """
        This function draws the gomoku table
        :return:
        """

        for row in range(ROWS+1):
            pygame.draw.line(self.play_window, COLOR_BLACK, (row*45 + 315 , 50), (row*45 + 315 ,650+30), width=1)
            pygame.draw.line(self.play_window, COLOR_BLACK, (315, row*45 + 50), (945, row*45 + 50), width=1)

    def draw_circle(self, color, x_pos, y_pos):
        """
        This function draws the stones already placed on the board
        :param color:
        :param x_pos: int
        :param y_pos: int
        :return:
        """
        pygame.draw.circle(self.play_window, color, (x_pos, y_pos), 20)

    def update_board(self , x_pos , y_pos , player):
        """
        This function updates the board
        :param x_pos: int
        :param y_pos: int
        :param player: int
        :return:
        """
        self.board[x_pos][y_pos] = player

    def player_stone(self , order):
        """
        This function executes the player s turn and updates the board
        :param order:
        :return:
        """

        x_pos, y_pos = pygame.mouse.get_pos()
        x_pos, y_pos = self.moves.fixing_x_and_y(x_pos, y_pos)
        x_pos = x_pos // 45 - 7
        y_pos = (y_pos - 5) // 45 - 1
        service_response = self.service.verify_if_on_board(x_pos, y_pos)
        if service_response["succes"] == True:
            service_response = self.service.verify_if_move_is_valid(x_pos, y_pos, self.board)
            if service_response["succes"] == True:
                self.update_board(x_pos, y_pos, 1)
                order = False
        return order

    def computer_turn(self, order):
        """
        This function executes the computer s turn and updates the board
        :param order: bool
        :return: bool
        """

        x_pos , y_pos  = self.check.calcultate_best_move(self.board)
        if x_pos ==None:
            x_pos = random.randint(7 , 20)
            y_pos = random.randint(1 , 14)
            x_pos = x_pos - 7
            y_pos = y_pos - 1
        service_response = self.service.verify_if_move_is_valid(x_pos, y_pos, self.board)
        if service_response["succes"] == True:
            self.update_board(x_pos, y_pos, -1)
            order = True
        return order

    def _start_window(self):
        """
        This function creates the start window
        :return:
        """

        #title and icon
        pygame.display.set_caption("Gomoku Menu")
        pygame.display.set_icon(ICON)

        running = True
        while running:
            #background
            self.start_window.fill((0 , 0 , 0))
            self.background(self.start_window , START_BACKGROUND)

            #mouse
            mouse_pos = pygame.mouse.get_pos()

            #buttons
            START_BUTTON = Button(image=pygame.image.load(start_button_path), pos=(200 , 600) )
            END_BUTTON = Button(image=pygame.image.load(exit_button_path) , pos =(450 , 600) )

            for button in [START_BUTTON , END_BUTTON]:
                button.update(self.start_window)

            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    running = False
                    pygame.quit()
                    sys.exit()
                if event.type == pygame.MOUSEBUTTONDOWN:
                    if START_BUTTON.check_for_input(mouse_pos):
                        self._play_window()

                    if END_BUTTON.check_for_input(mouse_pos):
                        pygame.quit()
                        sys.exit()

            pygame.display.update()

    def _play_window(self):
        """
        This function creates the playing window
        :return:
        """
        self.play_window = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
        pygame.display.set_caption("Gomoku Playing Area")
        pygame.display.set_icon(ICON)
        is_full = self.check.check_if_full(board=self.board)


        running = True
        while running:
            # background
            self.play_window.fill(COLOR_BROWN)
            self.play_window.blit(WHITE_BOWL , (0 ,200))
            self.play_window.blit(BLACK_BOWL, (970, 200))
            self.draw_gomoku_table()

            self.board , self.white_score , self.black_score = self.capture.verify_board( self.board , self.white_score , self.black_score)
            if self.check.check_if_full(board=self.board) == True:
                running = False
                winner = self.check.calculate_win(self.board , self.white_score , self.black_score)
                if winner == self.white_score and self.black_score != self.white_score:
                    self.winner_black_window()
                elif winner == self.black_score and self.black_score != self.white_score:
                    self.winner_black_window()
                else:
                    self.winner_black_window()
                    ##draw
            for row in range(15):
                for col in range(15):
                    if self.board[row][col] == 1:
                        self.draw_circle(COLOR_WHITE ,(row+7) * 45 , (col+1) * 45 + 5)
                    if self.board[row][col] == -1:
                        self.draw_circle(COLOR_BLACK ,(row+7) * 45 , (col+1) * 45 + 5)

            # mouse
            mouse_pos = pygame.mouse.get_pos()

            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    running = False
                    pygame.quit()
                    sys.exit()

                if event.type == pygame.MOUSEBUTTONDOWN:
                    if self.player_order:
                        self.player_order = self.player_stone(self.player_order)
                        if self.check.win_check(1 , self.board) != None:
                            self.winner_white_window()

                if not self.player_order:

                    self.player_order = self.computer_turn(self.player_order)
                    if self.check.win_check(-1 , self.board) != None:
                        self.winner_black_window()

            pygame.display.update()


    def winner_black_window(self):
        """
        This function creates the winner window
        :return:
        """

        self.lost_window = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
        pygame.display.set_caption("Gomoku Game Lost")
        pygame.display.set_icon(ICON)

        running = True
        while running:
            # background
            self.lost_window.fill(COLOR_BROWN)
            self.background(self.lost_window, LOST)
            pygame.display.update()
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    running = False
                    pygame.quit()
                    sys.exit()
        pygame.display.update()

    def winner_white_window(self):
        """
        This function creates the winner window
        :return:
        """

        self.won_window = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
        pygame.display.set_caption("Gomoku Game Won")
        pygame.display.set_icon(ICON)

        running = True
        while running:
            # background
            self.won_window.fill(COLOR_BROWN)
            self.background(self.won_window, WON)
            pygame.display.update()
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    running = False
                    pygame.quit()
                    sys.exit()
        pygame.display.update()


class Button(pygame.sprite.Sprite):
    def __init__(self , image , pos ):
        """
        This function creates a button
        :param image:
        :param pos:
        """
        super(Button , self).__init__()
        self.image = image
        self.x_pos = pos[0]
        self.y_pos = pos[1]
        self.rect = self.image.get_rect(center = (self.x_pos , self.y_pos))
        self.clicked = False


    def update(self ,screen):
        """
        This function updates the button
        :param screen:
        :return:
        """
        screen.blit(self.image, self.rect)


    def check_for_input(self ,position):
        """
        This function checks if the button was pressed
        :param position:
        :return: bool
        """
        if position[0] in range(self.rect.left, self.rect.right) and position[1] in range(self.rect.top, self.rect.bottom):
            return True
        return False




