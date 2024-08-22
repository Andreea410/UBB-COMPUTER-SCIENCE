from src.domain.person import Person


class PersonRepoException(Exception):
    def __init__(self, msg):
        self._msg = msg

class PersonRepo:
    def __init__(self, persons_list):
        self._persons = persons_list.copy()

    @property
    def persons(self):
        return self._persons

    def get_ids(self):
        ids=[]
        for i in self._persons:
            ids.append(i.id)
        return ids

    def unique_id(self,id):
        for person in self._persons:
            if person.id == id:
                return False
        return True

    def person_in_list(self,id):
        """
        checks if a given person is in the agenda
        :param id:
        :return:
        """
        for person in self._persons:
            if id == person.id:
                return True
        return False

    def add_person(self, id,name,phone):
        """
        adds a person to the repository
        :param person:
        :return:
        """
        person=Person(id,name,phone)
        if not self.unique_id(person.id):
            raise PersonRepoException ("Duplicate id!")
        else:
            self._persons.append(person)

    def remove_person(self,id_remove):
        """
        removes a person from the repo

        :param id_remove:
        :return:
        """

        ok=True
        i=0
        while i <= len(self._persons)-1 :
            if  self._persons[i].id==id_remove:
                self._persons.pop(i)
                ok=False
            else:
                i=i+1
        if ok:
            raise PersonRepoException("The person with the given id doesn't exist!")


    def update_person(self,id, name,phone_nr):
        """
        updates a person from the repo
        :param person:
        :return:
        """
        ok=True
        for p in self._persons:
            if id == p.id:
                p._name = name
                p._phone_nr = phone_nr
                ok= False
        if ok:
            raise PersonRepoException("The person to be updated doesn't exist!")

    def get_firstname(self,name):
        tokens=name.split()
        return tokens[0]

    def get_secondname(self,name):
        tokens=name.split()
        if len(tokens)>1:
            return tokens[1]
        else:
            return tokens

    def search_by_name(self,name):
        """
        searches a person in the repo by a given name
        :param name:
        :return:
        """
        ok= False
        lst=[]
        for person in self._persons:
            if person.name.lower().find(name.lower())!=-1 or self.get_firstname(person.name.lower())==self.get_secondname(name.lower()) or self.get_secondname(person.name.lower())== self.get_firstname(name.lower()):
                ok= True
                lst.append(person)
        if not ok:
            raise PersonRepoException("The person with the given name is not in the agenda!")
        return lst

    def search_by_id(self, pers_id):
        """
        searches a person by a given id
        :param pers_id:
        :return:
        """
        ok = False
        lst = []
        for person in self._persons:
            if person.id==pers_id:
               return person
        else:
            raise PersonRepoException("The person with the given id is not in the agenda!")



    def search_by_phone(self,phone_nr):
        """
        searches a person in the repo by the phone nr
        :param phone_nr:
        :return:
        """
        ok = False
        list=[]
        for person in self._persons:
            if person.phone_nr.find(phone_nr)!=-1:
                ok = True
                list.append(person)
        if not ok:
            raise PersonRepoException("The person with the given phone number is not in the agenda!")
        return list

    def __len__(self):
        """
        Returns the length of the repository
        :return:
        """
        return len(self._persons)




