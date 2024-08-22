from src.repository.person_repo import PersonRepo
import pickle

class PersonBinaryRepo(PersonRepo):
    def __init__(self, file_name):
        super().__init__([])
        self._file_name = file_name
        self.read_bin_file()

    def add_person(self, id,name,phone):
        super().add_person(id,name,phone)
        self.write_bin_file()

    def remove_person(self, id):
        super().remove_person(id)
        self.write_bin_file()

    def update_person(self, person, name, number):
        super().update_person(person,name,number)
        self.write_bin_file()


    def write_bin_file(self):
        f = open(self._file_name, 'wb')
        pickle.dump(self._persons, f)
        f.close()

    def read_bin_file(self):
        result = []
        try:
            f = open(self._file_name, 'rb')
            self._persons = pickle.load(f)
            f.close()
            return self._persons
        except EOFError:
            return result
        except IOError as e:
            raise e