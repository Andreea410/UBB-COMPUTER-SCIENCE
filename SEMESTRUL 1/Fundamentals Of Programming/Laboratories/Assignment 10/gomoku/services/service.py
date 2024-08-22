
class Service():
    def __init__(self):
        pass

    def verify_if_move_is_valid(self , x : int , y :int , board):
        """
        This function verifies if the move is valid and if it hasn t been done already
        :param x: int
        :param y: int
        :param board:list
        :return: dict
        """
        service_response = {"succes" : True , "message" : "Your stone was placed on the table"}
        if board[x][y] == 0:
            return service_response
        else:
            service_response["succes"] = False
            service_response["message"] = "The place you chose is already occupied"
            return service_response

    def verifiy_if_int(self , x , y):
        """
        This function verifies if the values are integers
        :param x:
        :param y:
        :return:
        """
        service_response = {"succes" : True , "message" : f"Your stone was placed on row {x} and column {y}"}
        try:
            x = int(x)
            y = int(y)
        except ValueError:
            service_response["succes"] = False
            service_response["message"] = "The values you entered are not integers"

        return service_response

    def verify_if_on_board(self , x:int , y:int):
        """
        This function verifies if the values are on the board
        :param x: int
        :param y: int
        :return: dict
        """

        service_response = {"succes" : True , "message" : "Your stone was placed on the table"}
        if x < 0 or x > 14 or y < 0 or y > 14:
            service_response["succes"] = False
            service_response["message"] = "The values you entered are outside the board"
            return service_response
        return service_response