from src.services import Service

class UserInterface:

    def __init__(self):
        self.__services = Service()

    def start_ui(self):
        """

        :return:
        """


        service = self.__services.sort_descending()
        if service["succes"] == True:
            self.players = service["data"]
            for player in self.players:
                print(player)
        else:
            print(service["message"])
        service_response = self.__services.verification_if_power_of_two(len(self.players))
        if service_response["succes"] == False:
            self.run_qualifications()
        if len(self.players) == 8:
            self.run_quarter_finals()
        if len(self.players) == 4:
            self.run_semifinals()
        if len(self.players) == 2:
            self.run_finals()
            for player in self.players:
                print(f"And the winner is ... {player}")



    def run_qualifications(self):
        """

        :return:
        """
        print("Qualifications")
        if len(self.players) == 5:
            service = self.__services.qualifications_for_5()
            for player in service["data"]:
                print(player)
        elif len(self.players) == 7:
            service = self.__services.qualifications_for_7()
            ids = service["data"]
            for i in range(3):
                service = self.__services.qual_round(ids)
                print(service["message"])
                winner = input("Please choose your winner: ")
                if winner == '1':
                    self.__services.remove_loser(service["data player 2"])

                elif winner == '2':
                    self.__services.remove_loser(service["data player 1"])

        elif len(self.players) == 13:
            service = self.__services.qualifications_for_13()
            ids = service["data"]
            for i in range(5):
                service = self.__services.qual_round(ids)
                print(service["message"])
                winner = input("Please choose your winner: ")
                if winner == '1':
                    self.__services.remove_loser(service["data player 2"])
                    service = self.__services.increase_player_strength(service["data player 1"])

                elif winner == '2':
                    self.__services.remove_loser(service["data player 1"])
                    service = self.__services.increase_player_strength(service["data player 2"])
        elif len(self.players) == 3:
            self.__services.remove_loser(self.players[2])

        elif len(self.players) == 9:
            self.__services.remove_loser(self.players[8])


    def run_quarter_finals(self):
        """

        :return:
        """
        print("Last 8")
        service = self.__services.quarter_finals()
        ids = service["data"]
        for i in range(4):
            service = self.__services.qual_round(ids)
            print(service["message"])
            winner = input("Please choose your winner: ")
            if winner == '1':
                self.__services.remove_loser(service["data player 2"])
                service = self.__services.increase_player_strength(service["data player 1"])

            elif winner == '2':
                self.__services.remove_loser(service["data player 1"])
                service = self.__services.increase_player_strength(service["data player 2"])

    def run_semifinals(self):
        """

        :return:
        """

        print("Last 4")
        service = self.__services.semifinals()
        ids = service["data"]
        for i in range(2):
            service = self.__services.qual_round(ids)
            print(service["message"])
            winner = input("Please choose your winner: ")
            if winner == '1':
                self.__services.remove_loser(service["data player 2"])
                service = self.__services.increase_player_strength(service["data player 1"])

            elif winner == '2':
                self.__services.remove_loser(service["data player 1"])
                service = self.__services.increase_player_strength(service["data player 2"])

    def run_finals(self):
        print("Last 2")

        service = self.__services.final()
        ids = service["data"]
        for i in range(1):
            service = self.__services.qual_round(ids)
            print(service["message"])
            winner = input("Please choose your winner: ")
            if winner == '1':
                self.__services.remove_loser(service["data player 2"])
                service = self.__services.increase_player_strength(service["data player 1"])

            elif winner == '2':
                self.__services.remove_loser(service["data player 1"])
                service = self.__services.increase_player_strength(service["data player 2"])


