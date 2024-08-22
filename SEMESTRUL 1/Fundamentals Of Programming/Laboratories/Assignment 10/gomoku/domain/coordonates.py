
class Coordonates:
    def __init__(self):
        pass

    def fixing_x_and_y(self , x , y):
        """
        This function fixes the x and y values so that the stone is placed in the middle of the closest square
        :param x: int
        :param y: int
        :return: int , int
        """

        if abs(x % 45) < abs (45 - x%45):
            while x % 45:
                x -= 1
        else:
            while x % 45:
                x += 1

        if (y - 45*((y-5)//45)+5) < (45*((y-5)//45 + 1)+5 - y):
            while (y-5) % 45:
                y -= 1
        else:
            while (y-5) % 45:
                y += 1
        return x , y