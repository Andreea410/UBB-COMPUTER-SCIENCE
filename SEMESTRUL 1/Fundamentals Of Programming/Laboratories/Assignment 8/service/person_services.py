from src.domain.person import PersonValidator, Person
from src.repository.activity_repo import ActivityRepo
from src.repository.person_repo import PersonRepo


class PersonService:
    def __init__(self,persons_repo:PersonRepo,validator:PersonValidator):
        self._repo=persons_repo
        self._validator=validator


    @property
    def persons(self):
        return self._repo.persons

    def add(self, id,name,phone):
        """
        adds a person to the agenda
        :param person:
        :return:
        """
        person=Person(id,name,phone)
        self._validator.valid_person(person)
        self._repo.add_person(id,name,phone)

    def remove(self,person_id):
        """
        removes a person with a given id
        :param person_id:
        :return:
        """
        person = self._repo.search_by_id(person_id)
        self._validator.valid_id(person_id)
        self._repo.remove_person(person_id)



    def update(self,id,name,phone_nr):
        """
        updates a person s name and phone nr
        :param person:
        :return:
        """
        person=self._repo.search_by_id(id)
        previous_name=person.name
        previous_number=person.phone_nr
        self._validator.valid_person(Person(id,name,phone_nr))
        self._repo.update_person(id,name,phone_nr)


    def search_name(self,name):
        """
        searches a person by his/her name
        :param id:
        :return:
        """
        self._validator.valid_name(name)
        list=self._repo.search_by_name(name)
        return list

    def search_phone(self,phone):
        """
        searches a person by his/her phone number
        :param phone:
        :return:
        """
        self._validator.valid_phonenr(phone)
        list=self._repo.search_by_phone(phone)
        return list


    def __len__(self):
        """
        Returns the length of the repository
        :return:
        """
        return len(self._repo)

