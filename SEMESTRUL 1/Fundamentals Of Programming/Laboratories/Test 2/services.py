from src.repository import RepositoryError , Repository

class Service:

    def __init__(self):
        self.__repository = Repository()

    def sort_descending(self):
        service_response = {"succes" : True , "message" : "The players were sorted succesfully" , "data":[]}
        try:
            list = self.__repository.sort_descending()
            service_response["data"] = list
        except RepositoryError as re:
            service_response["succes"] = False
            service_response["message"] = str(re)
        return service_response

    def qualifications_for_5(self):
        service_response = {"succes": True, "message": "The players were sorted succesfully", "data": []}
        try:
            players = self.__repository.qualifications_for_5()
            service_response["data"] = players

        except RepositoryError as re:
            service_response["succes"] = False
            service_response["message"] = str(re)
        return service_response

    def qualifications_for_7(self):
        service_response = {"succes": True, "message": "The players were sorted succesfully", "data players":[]}
        try:
            players,ids = self.__repository.qualifications_for_7()
            service_response["data"] = ids
        except RepositoryError as re:
            service_response["succes"] = False
            service_response["message"] = str(re)
        return service_response

    def qual_round(self , ids):
        """
        this function verifies if the repository executes it correctly
        :param ids: list
        :return: dict
        """
        service_response = {"succes": True, "message": "The players were sorted succesfully",
                            "data player 1": [] , "data player 2":[]}
        try:
            player_one , player_two = self.__repository.qual_rounds(ids) #gets the player one and the player two
            service_response["data player 1"] = player_one # adds player one into the dict
            service_response["data player 2"] = player_two # adds player two into the dict
            service_response["message"] = f"The round takes place between {player_one} and {player_two}"
        except RepositoryError as re:
            service_response["succes"] = False
            service_response["message"] = str(re)
        return service_response

    def remove_loser(self , player):

        self.__repository.remove_loser(player)

    def increase_player_strength(self , player):
        service_response = {"succes": True, "message": "The players were sorted succesfully", "data players": []}
        try:
            self.__repository.increase_winner_strength(player)
        except RepositoryError as re:
            service_response["succes"] = False
            service_response["message"] = str(re)
        return service_response


    def qualifications_for_13(self):
        service_response = {"succes": True, "message": "The players were sorted succesfully", "data players": []}
        try:
            ids = self.__repository.qualifications_for_13()
            service_response["data"] = ids
        except RepositoryError as re:
            service_response["succes"] = False
            service_response["message"] = str(re)
        return service_response

    def quarter_finals(self):
        service_response = {"succes": True, "message": "The players were sorted succesfully", "data": []}
        try:
            ids = self.__repository.quarter_finals()
            service_response["data"] = ids
        except RepositoryError as re:
            service_response["succes"] = False
            service_response["message"] = str(re)
        return service_response

    def semifinals(self):
        service_response = {"succes": True, "message": "The players were sorted succesfully", "data": []}
        try:
            ids = self.__repository.semifinals()
            service_response["data"] = ids
        except RepositoryError as re:
            service_response["succes"] = False
            service_response["message"] = str(re)
        return service_response

    def final(self):
        service_response = {"succes": True, "message": "The players were sorted succesfully", "data": []}
        try:
            ids = self.__repository.final()
            service_response["data"] = ids
        except RepositoryError as re:
            service_response["succes"] = False
            service_response["message"] = str(re)
        return service_response

    def verification_if_power_of_two(self , number):
        """

        :return:
        """
        service_response = {"succes": True, "data": []}
        try:
            ok = self.__repository.verification_if_power_two(number)
            if not ok:
                service_response["succes"] = False
        except RepositoryError as re:
            service_response["succes"] = False
            service_response["message"] = str(re)
        return service_response
