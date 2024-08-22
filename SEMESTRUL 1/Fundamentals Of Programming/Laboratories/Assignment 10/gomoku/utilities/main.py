import os
import pygame

#size window
SCREEN_WIDTH = 1250
SCREEN_HEIGHT = 703

#board size
ROWS = 14
COLS = 14

BOARD_WIDTH_START = 50
BOARD_WIDTH_END =  680

BOARD_HEIGHT_TOP = 315
BOARD_HEIGHT_BOTTOM = 945


#images
current_dir = os.path.dirname(os.path.realpath(__file__))
icon_path = os.path.join(current_dir, 'icon.png')
ICON = pygame.image.load(icon_path)

current_dir = os.path.dirname(os.path.realpath(__file__))
start_background_path = os.path.join(current_dir, 'start_window_background.jpg')
START_BACKGROUND = pygame.image.load(start_background_path)

current_dir = os.path.dirname(os.path.realpath(__file__))
lost_path = os.path.join(current_dir, 'lost.jpg')
LOST = pygame.image.load(lost_path)

current_dir = os.path.dirname(os.path.realpath(__file__))
won_path = os.path.join(current_dir, 'won.jpg')
WON = pygame.image.load(won_path)


#buttons
current_dir = os.path.dirname(os.path.realpath(__file__))
start_button_path = os.path.join(current_dir, 'start-button.png')

current_dir = os.path.dirname(os.path.realpath(__file__))
exit_button_path = os.path.join(current_dir, 'exit.png')



#bowls
current_dir = os.path.dirname(os.path.realpath(__file__))
white_bowl_path = os.path.join(current_dir, 'white_pieces.png')
WHITE_BOWL = pygame.image.load(white_bowl_path)

current_dir = os.path.dirname(os.path.realpath(__file__))
black_bowl_path = os.path.join(current_dir, 'black_pieces.png')
BLACK_BOWL = pygame.image.load(black_bowl_path)

#color
COLOR_BLACK = (0, 0, 0)
COLOR_WHITE = (255, 255, 255)
COLOR_BROWN = (102 , 51 , 0)