class Player:

    def __init__(self, id , name , playing_strength) -> None:
        self.id = id
        self.name = name
        self.playing_strength = playing_strength

    @property
    def get_id(self):
        return self.id

    @property
    def get_name(self):
        return self.name
    @property
    def get_playing_strength(self):
        return self.playing_strength
    def Player(self) -> dict:

        return {"id":self.get_id , "name": self.get_name , "playing strength": self.get_playing_strength}

