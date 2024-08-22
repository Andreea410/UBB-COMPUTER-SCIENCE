from src.repository.person_repo import PersonRepo


class PersonTextFileRepository(PersonRepo):
    def __init__(self, file_name):
        super().__init__([])
        self._file_name = file_name
        self._load()

    def add_person(self, id, name, phone):
        super().add_person(id, name, phone)
        self._save()

    def update_person(self, person, name, number):
        super().update_person(person, name, number)
        self._save()

    def remove_person(self,id_remove):
        super().remove_person(id_remove)
        self._save()

    def _save(self):
        f = open(self._file_name, 'wt')
        for person in self.persons:
            line = str(person.id) + ';' + str(person.name) + ';' + str(person.phone_nr)
            f.write(line)
            f.write('\n')
        f.close()

    def _load(self):
        """
        Load data from file
        We assume file-saved data is valid
        """
        f = open(self._file_name, 'rt')  # read text
        lines = f.readlines()
        f.close()

        for line in lines:
            line = line.split(';')
            if len(line) == 3:
                super().add_person(int(line[0]), line[1], line[2].strip('\n'))

