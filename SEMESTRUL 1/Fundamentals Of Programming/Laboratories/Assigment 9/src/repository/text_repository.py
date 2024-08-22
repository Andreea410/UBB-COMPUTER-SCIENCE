from src.repository.main import Repository
from src.domain.person import Person
from src.domain.activity import Activity
import os
from dotenv import load_dotenv

class TextRepository(Repository):
    def __init__(self):
        load_dotenv()
        super().__init__()

        self.data_folder = "data/"
        self.__create_folder()

        self.activities_file = os.getenv("ACTIVITY_FILE")
        self.person_file = os.getenv("PERSON_FILE")

        self.__create_file(self.activities_file)
        self.__create_file(self.person_file)

        self.__load_activities()
        self.__load_person()

        self.__save_activities()
        self.__save_person()

    def __check_if_folder_exists(self):
        return os.path.exists(self.data_folder)

    def __check_if_file_exists(self, file_name):
        try:
            with open(self.data_folder + file_name, "r") as file:
                return True
        except FileNotFoundError:
            return False

    def __create_folder(self):
        if not self.__check_if_folder_exists():
            os.mkdir(self.data_folder)

    def __create_file(self, file_name):
        if not self.__check_if_file_exists(file_name):
            with open(self.data_folder + file_name, "w") as file:
                pass

    def __load_activities(self):
        activities = []
        with open(self.data_folder + self.activities_file, "r") as file:
            for line in file:
                line = line.strip()
                if line == "":
                    continue
                line = line.split(",")
                activities.append(Activity(
                    line[0], line[1] , line[2] , line[3] , line[4] , line[5]))
        if len(activities) > 0:
            self.activities = activities

    def __load_person(self):
        person = []
        with open(self.data_folder + self.person_file, "r") as file:
            for line in file:
                line = line.strip()
                if line == "":
                    continue
                line = line.split(",")
                person.append(Person(
                    line[0], line[1] , line[2]))
        if len(person) > 0:
            self.persons = person

    def __save_activities(self):
        with open(self.data_folder + self.activities_file, "w") as file:
            for activity in self.activities:
                file.write(f"{activity.activity_id},{activity.person_ids},{activity.date},{activity.start_time},{activity.end_time},{activity.description}")

    def __save_person(self):
        with open(self.data_folder + self.person_file, "w") as file:
            for person in self.persons:
                file.write(f"{person.person_id},{person.name},{person.number}\n")

    def add_activity(self, activity):
        super().add_activity(activity)
        self.__save_activities()

    def remove_activity(self, activity):
        super().remove_activity(activity)
        self.__save_activities()

    def update_activity(self, activity):
        super().update_activity(activity)
        self.__save_activities()

    def add_person(self, person):
        super().add_person(person)
        self.__save_person()

    def remove_person(self, person):
        super().remove_person(person)
        self.__save_person()

    def update_person(self, person):
        super().update_person(person)
        self.__save_person()


