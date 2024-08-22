
class Captured:
    def __init__(self):
        pass
    def verify_if_captured(self ,player ,  x_pos , y_pos , board):

        if x_pos == 0 and y_pos == 0:
            if not board[x_pos+1][y_pos] or not board[x_pos][y_pos+1]:
                return False
            elif board[x_pos+1][y_pos] == player*(-1) and board[x_pos][y_pos+1] == player*(-1):
                return True
            elif board[x_pos+1][y_pos] == player*(-1) and board[x_pos][y_pos+1] == player:
                return self.verify_if_captured(player , x_pos , y_pos+1 , board)
            elif board[x_pos+1][y_pos] == player and board[x_pos][y_pos+1] == player*(-1):
                return self.verify_if_captured(player , x_pos+1 , y_pos , board)

        elif x_pos == 0 and y_pos == 14:
            if not board[x_pos+1][y_pos] or not board[x_pos][y_pos-1]:
                return False
            elif board[x_pos+1][y_pos] == player*(-1) and board[x_pos][y_pos-1] == player*(-1):
                return True
            elif board[x_pos+1][y_pos] == player*(-1) and board[x_pos][y_pos-1] == player:
                return self.verify_if_captured(player , x_pos , y_pos-1 , board)
            elif board[x_pos+1][y_pos] == player and board[x_pos][y_pos-1] == player*(-1):
                return self.verify_if_captured(player , x_pos+1 , y_pos , board)

        elif x_pos == 14 and y_pos == 0:
            if not board[x_pos - 1][y_pos] or not board[x_pos][y_pos + 1]:
                return False
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos][y_pos + 1] == player * (-1):
                return True
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos][y_pos + 1] == player:
                return self.verify_if_captured(player, x_pos, y_pos + 1 , board)
            elif board[x_pos - 1][y_pos] == player and board[x_pos][y_pos + 1] == player * (-1):
                return self.verify_if_captured(player, x_pos - 1, y_pos , board)

        elif x_pos == 14 and y_pos == 14:
            if not board[x_pos - 1][y_pos] or not board[x_pos][y_pos - 1]:
                return False
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos][y_pos - 1] == player * (-1):
                return True
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos][y_pos - 1] == player:
                return self.verify_if_captured(player, x_pos, y_pos - 1 , board)
            elif board[x_pos - 1][y_pos] == player and board[x_pos][y_pos - 1] == player * (-1):
                return self.verify_if_captured(player, x_pos - 1, y_pos , board)

        elif y_pos == 0:
            if not board[x_pos - 1][y_pos] or not board[x_pos + 1][y_pos] or not board[x_pos][y_pos + 1]:
                return False
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos + 1][y_pos] == player * (-1) and board[x_pos][y_pos + 1] == player * (-1):
                return True
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos + 1][y_pos] == player * (-1) and board[x_pos][y_pos + 1] == player:
                return self.verify_if_captured(player, x_pos, y_pos + 1 , board)
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos + 1][y_pos] == player and board[x_pos][y_pos + 1] == player * (-1):
                return self.verify_if_captured(player, x_pos + 1, y_pos , board)
            elif board[x_pos - 1][y_pos] == player and board[x_pos + 1][y_pos] == player * (-1) and board[x_pos][y_pos + 1] == player * (-1):
                return self.verify_if_captured(player, x_pos - 1, y_pos , board)

        elif y_pos == 14:
            if not board[x_pos - 1][y_pos] or not board[x_pos + 1][y_pos] or not board[x_pos][y_pos - 1]:
                return False
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos + 1][y_pos] == player * (-1) and board[x_pos][y_pos - 1] == player * (-1):
                return True
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos + 1][y_pos] == player * (-1) and board[x_pos][y_pos - 1] == player:
                return self.verify_if_captured(player, x_pos, y_pos - 1 , board)
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos + 1][y_pos] == player and board[x_pos][y_pos - 1] == player * (-1):
                return self.verify_if_captured(player, x_pos + 1, y_pos , board)
            elif board[x_pos - 1][y_pos] == player and board[x_pos + 1][y_pos] == player * (-1) and board[x_pos][y_pos - 1] == player * (-1):
                return self.verify_if_captured(player, x_pos - 1, y_pos , board)

        elif x_pos == 0:
            if not board[x_pos+1][y_pos] or not board[x_pos][y_pos-1] or not board[x_pos][y_pos+1]:
                return False
            elif board[x_pos+1][y_pos] == player*(-1) and board[x_pos][y_pos-1] == player*(-1) and board[x_pos][y_pos+1] == player*(-1):
                return True
            elif board[x_pos+1][y_pos] == player*(-1) and board[x_pos][y_pos-1] == player*(-1) and board[x_pos][y_pos+1] == player:
                return self.verify_if_captured(player , x_pos , y_pos+1 , board)
            elif board[x_pos+1][y_pos] == player*(-1) and board[x_pos][y_pos-1] == player and board[x_pos][y_pos+1] == player*(-1):
                return self.verify_if_captured(player , x_pos , y_pos-1 , board)
            elif board[x_pos+1][y_pos] == player and board[x_pos][y_pos-1] == player*(-1) and board[x_pos][y_pos+1] == player*(-1):
                return self.verify_if_captured(player , x_pos+1 , y_pos , board)

        elif x_pos == 14:
            if not board[x_pos - 1][y_pos] or not board[x_pos][y_pos - 1] or not board[x_pos][y_pos + 1]:
                return False
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos][y_pos - 1] == player * (-1) and board[x_pos][y_pos + 1] == player * (-1):
                return True
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos][y_pos - 1] == player * (-1) and board[x_pos][y_pos + 1] == player:
                return self.verify_if_captured(player, x_pos, y_pos + 1 , board)
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos][y_pos - 1] == player and board[x_pos][y_pos + 1] == player * (-1):
                return self.verify_if_captured(player, x_pos, y_pos - 1 , board)
            elif board[x_pos - 1][y_pos] == player and board[x_pos][y_pos - 1] == player * (-1) and board[x_pos][y_pos + 1] == player * (-1):
                return self.verify_if_captured(player, x_pos - 1, y_pos , board)

        else:
            if not board[x_pos - 1][y_pos] or not board[x_pos + 1][y_pos] or not board[x_pos][y_pos - 1] or not board[x_pos][y_pos + 1]:
                return False
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos + 1][y_pos] == player * (-1) and board[x_pos][y_pos - 1] == player * (-1) and board[x_pos][y_pos + 1] == player * (-1):
                return True
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos + 1][y_pos] == player * (-1) and board[x_pos][y_pos - 1] == player * (-1) and board[x_pos][y_pos + 1] == player:
                return self.verify_if_captured(player, x_pos, y_pos + 1 , board)
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos + 1][y_pos] == player * (-1) and board[x_pos][y_pos - 1] == player and board[x_pos][y_pos + 1] == player * (-1):
                return self.verify_if_captured(player, x_pos, y_pos - 1 , board)
            elif board[x_pos - 1][y_pos] == player * (-1) and board[x_pos + 1][y_pos] == player and board[x_pos][y_pos - 1] == player * (-1) and board[x_pos][y_pos + 1] == player * (-1):
                return self.verify_if_captured(player, x_pos + 1, y_pos , board)
            elif board[x_pos - 1][y_pos] == player and board[x_pos + 1][y_pos] == player * (-1) and board[x_pos][y_pos - 1] == player * (-1) and board[x_pos][y_pos + 1] == player * (-1):
                return self.verify_if_captured(player, x_pos - 1, y_pos , board)

        return False

    def verify_board(self , board , white_score , black_score):
        for row in range(len(board)):
            for col in range(len(board)):
                if board[row][col] == 1:
                    if self.verify_if_captured(1 , row , col , board):
                        board[row][col] = 0
                        black_score+=1

                if board[row][col] == -1:
                    if self.verify_if_captured(-1 , row , col , board):
                        board[row][col] = 0
                        white_score+=1
        return board , white_score , black_score


class Win:

    def __init__(self):
        pass

    def row_check(self , player, board):

        for i in range(len(board)):
            if board[i].count(1) >= 5:

                for z in range(len(board) - 3):
                    Connection = 0

                    for c in range(5):
                        if z+c < len(board[i]):
                            if board[i][z + c] == player:
                                Connection += 1

                            else:
                                break

                        if Connection == 5:
                            return True

    def win_check(self , player , board):

        if (self.row_check(player , board) or self.row_check(player, self.transpose(board))
                or self.row_check(player,self.transpose_diagonal_inc(board)) or self.row_check(player, self.transpose_diagonal_dec(board))):

            return player
        return None

    def get_diagonal_dec(self, dig_num , board):
        lst = []
        if dig_num <= len(board) - 1:
            index = len(board) - 1
            for i in range(dig_num, -1, -1):
                lst.append(board[i][index])
                index -= 1
            return lst
        else:
            index = (len(board) * 2 - 2) - dig_num
            for i in range(len(board) - 1, dig_num - len(board), -1):
                lst.append(board[i][index])
                index -= 1
            return lst

    def transpose_diagonal_dec(self , board):
        lst = []
        for i in range(len(board) * 2 - 1):
            lst.append(self.get_diagonal_dec(i , board))
        return lst

    def get_diagonal_inc(self, dig_num , board):
        lst = []
        if dig_num <= len(board) - 1:
            index = 0
            for i in range(dig_num, -1, -1):
                lst.append(board[i][index])
                index += 1
            return lst
        else:
            index = dig_num - len(board) + 1
            for i in range(len(board) - 1, dig_num - len(board), -1):
                lst.append(board[i][index])
                index += 1
            return lst

    def transpose_diagonal_inc(self , board):
        lst = []
        for i in range(len(board) * 2 - 1):
            lst.append(self.get_diagonal_inc(i , board))
        return lst

    def transpose(self, board):
        lst = []
        for i in range(len(board)):
            lst.append([row[i] for row in board])
        return lst

    def get_col(self , col_number , board):
        lst = []
        for i in range(len(board)):
            lst.append(board[i][col_number])
        return lst

    def check_if_full(self , board):
        """
        This function checks if the board is full
        :param board: list
        :return: bool
        """
        total_sum = 0
        for row in range(len(board)):
            for col in range(len(board)):
                if board[row][col] == 0:
                    return False
        return True

    def calculate_win(self , board , white_score , black_score):

        if white_score > black_score:
            return white_score
        elif white_score < black_score:
            return black_score
        else:
            return None

    def calculate_possible_moves(self , board):

        possible_moves = []
        for i in range(len(board)):
            for j in range(len(board)):
                if board[i][j] == 0:
                    possible_moves.append({"x": i , "y": j})
        return possible_moves
    def calcultate_best_move(self , board):

        possible_moves = self.calculate_possible_moves(board)
        for move in possible_moves:
            x = move["x"]
            y = move["y"]
            board[x][y] = 1
            if self.win_check(1,board) != None:
                board[x][y] = 0
                return x , y
            board[x][y] = 0

        return None , None