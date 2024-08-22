import unittest

from gomoku.domain.board import *
from gomoku.domain.check import *
from gomoku.domain.moves import *
from gomoku.services.service import *

class TestCheck(unittest.TestCase):
    def setUp(self):
        self.check = Captured()
        self.board = []
        for x in range(15):
            row = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            self.board.append(row)

    def test_verify_if_captured(self):
        self.board[0][0] = 0
        self.board[0][1] = 1
        self.board[0][2] = 1
        self.board[0][3] = 1
        self.board[1][0] = 1
        self.assertEqual(self.check.verify_if_captured(0, 0, 0, self.board), False)

    def test_verify_board(self):
        self.assertEqual(self.check.verify_board(self.board , 0, 0), (self.board , 0 ,0))

    def tearDown(self):
        print('TORN DOWN')

class TestWin(unittest.TestCase):
    def setUp(self):
        self.win = Win()
        self.board = []
        for x in range(15):
            row = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            self.board.append(row)


    def test_row_check(self):
        self.board[0][0] = 1
        self.board[0][1] = 1
        self.board[0][2] = 1
        self.board[0][3] = 1
        self.board[0][4] = 1
        self.assertEqual(self.win.row_check(1 , self.board), True)

    def test_win_check(self):
        self.assertEqual(self.win.win_check(1 , self.board), None)

    def test_get_diagonal_dec(self):
        self.assertEqual(self.win.get_diagonal_dec(1 , self.board), [0 , 0])

    def test_get_diagonal_inc(self):
        self.assertEqual(self.win.get_diagonal_inc(1 , self.board), [0 , 0])

    def test_transpose(self):
        self.assertEqual(self.win.transpose(self.board), self.board)

    def test_get_col(self):
        self.assertEqual(self.win.get_col(1 , self.board), [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    def test_check_if_full(self):
        self.assertEqual(self.win.check_if_full(self.board), False)

    def test_calcultate_win(self):
        self.assertEqual(self.win.calculate_win(self.board , 0 , 0), None)

    def tearDown(self):
        print('TORN DOWN')

class TestMoves(unittest.TestCase):
    def setUp(self):
        self.move = Move()

    def test_fixing_x_and_y(self):
        self.assertEqual(self.move.fixing_x_and_y(1 , 1), (0 , 5))

class TestService(unittest.TestCase):

    def setUp(self):
        self.service = Service()
        self.board = []
        for x in range(15):
            row = [0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,0 , 0 , 0 , 0 , 0]
            self.board.append(row)
        self.win = Win()
        self.captured = Captured()
        self.move = Move()

    def test_verify_if_int(self):
        self.assertEqual(self.service.verifiy_if_int(1 , 1), {'succes': True, 'message': 'Your stone was placed on row 1 and column 1'})

    def test_verify_if_on_board(self):
        self.assertEqual(self.service.verify_if_on_board(1 , 1), {'succes': True, 'message': 'Your stone was placed on the table'})

    def test_verify_if_move_is_valid(self):
        self.assertEqual(self.service.verify_if_move_is_valid(1 , 1 , self.board), {'succes': True, 'message': 'Your stone was placed on the table'})

    def tearDown(self):
        print('TORN DOWN')