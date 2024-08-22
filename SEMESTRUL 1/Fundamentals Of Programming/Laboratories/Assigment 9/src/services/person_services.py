from src.domain.person import PersonValidator, Person
from src.repository.activity_repo import ActivityRepo
from src.repository.person_repo import PersonRepo
from src.repository.undo_redo import FunctionCall, Operation


class PersonService:
    def __init__(self,persons_repo:PersonRepo,validator:PersonValidator,undo):
        self._repo=persons_repo
        self._validator=validator
        self._undo=undo


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
        undo_fun = FunctionCall(self._repo.remove_person, person.id)
        redo_fun = FunctionCall(self._repo.add_person, id,name,phone)
        o = Operation(undo_fun, redo_fun)
        self._undo.record(o)

    def remove(self,person_id):
        """
        removes a person with a given id
        :param person_id:
        :return:
        """
        person = self._repo.search_by_id(person_id)
        self._validator.valid_id(person_id)
        self._repo.remove_person(person_id)
        undo_fun = FunctionCall(self._repo.add_person, person.id,person.name,person.phone_nr)
        redo_fun = FunctionCall(self._repo.remove_person, person_id)
        o = Operation(undo_fun, redo_fun)
        self._undo.record(o)


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
        undo_fun = FunctionCall(self._repo.update_person, id,previous_name,previous_number)
        redo_fun = FunctionCall(self._repo.update_person, id,name,phone_nr)
        o = Operation(undo_fun, redo_fun)
        self._undo.record(o)

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

