import os
import random

class RepositoryError(Exception):
    def __init__(self , message):
        self.message = message

    def message(self):
        return self.message

    def __str__(self):
        return self.message

class Repository:

    def __init__(self):
        current_dir = os.path.dirname(os.path.abspath(__file__))
        self.file_path = os.path.join(current_dir , 'players.txt')
        self.load_players()
        self.save_players()


    def load_players(self):

        self.players = []
        with open(self.file_path , 'r') as f:
            for line in f:
                line = line.strip()
                line = line.split(',')
                player = {"id" :line[0] , "name":line[1], "playing strength" :line[2]}
                self.players.append(player)


    def save_players(self):
        """

        :return:
        """
        with open(self.file_path , 'w') as f:
            for player in self.players:
                f.write(f"{player["id"]},{player["name"]},{int(player["playing strength"])} \n")

    def sort_descending(self):
        if len(self.players)< 1:
            raise RepositoryError("There needs to be at least one player.")
        self.players = sorted(self.players , key = lambda x : x["playing strength"] , reverse=True)
        players = self.players
        return players

    def qualifications_for_5(self):
        if len(self.players) % 2 == 0:
            raise RepositoryError("The qualifications are played only if the number of players is odd. ")
        if len(self.players) == 5:
            self.players.pop()
            players = self.players
            return players


    def qualifications_for_7(self):
        if not self.verification_if_power_two(len(self.players)):
            raise RepositoryError("The qualifications are played only if the number of players is odd. ")
        if len(self.players) == 7:
            lowest_players = []
            ids = []
            for i in range(1, 7):
                ids.append(self.players[i]["id"])

        return ids

    def qualifications_for_13(self):
        if len(self.players) % 2 == 0:
            raise RepositoryError("The qualifications are played only if the number of players is odd. ")
        if len(self.players) == 13:
            ids = self.get_last_players(10)

        return  ids


    def qual_rounds(self , ids):
        """
        this functions chooses 2 random players which are about to play

        :param ids:list
        :return:dict , dict
        """
        player_one = random.choice(ids) ## chooses a random id from the list of ids
        ids.remove(player_one) # removes the id already chosen
        player_two = random.choice(ids)
        ids.remove(player_two)
        for player in self.players:
            if player["id"] == player_one:
                player_one = player
            elif player["id"] == player_two:
                player_two = player
        if not isinstance(player_one , dict) or not isinstance(player_two,dict):
            raise RepositoryError("No players this round")
        return player_one , player_two

    def remove_loser(self , player):
        self.players.remove(player)
        self.save_players()

    def increase_winner_strength(self , player):
        """

        :return:
        """
        if player in self.players:
            player["playing strength"] = int(player["playing strength"]) + 1
        else:
            raise RepositoryError("There is no player.")
        self.save_players()

    def get_last_players(self , number):
        """

        :param number:
        :return:
        """
        ids = []
        number = len(self.players) - number
        for i in range(len(self.players)-1,number-1, -1):
            ids.append(self.players[i]["id"])
        return ids

    def quarter_finals(self):
        """

        :return:
        """

        ids = self.get_last_players(8)
        return ids

    def semifinals(self):
        """

        :return:
        """
        ids = self.get_last_players(4)
        return ids

    def final(self):
        """

        :return:
        """
        ids = self.get_last_players(2)
        return ids

    def verification_if_power_two(self , number):

        while number:
            number /= 2
            if not isinstance(number ,int):
                return False
        return True



