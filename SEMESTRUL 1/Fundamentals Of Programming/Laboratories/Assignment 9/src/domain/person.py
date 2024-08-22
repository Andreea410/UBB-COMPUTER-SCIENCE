class PersonException(Exception):
    def __init__(self, msg):
        super().__init__(self, msg)

class PersonValidationException(PersonException):
    def __init__(self, error_list):
        self._errors = error_list

    def __str__(self):
        result = ''
        for er in self._errors:
            result += er
            result += '\n'
        return result

class PersonValidator:
    @staticmethod
    def valid_id(person_id):
        if person_id < 1 or not isinstance(person_id,int) :
            return False
        return True

    @staticmethod
    def valid_name(name):
        names = name.strip().split(' ')
        new_name = ''
        for n in range(len(names)):
            new_name += names[n].strip()
        return new_name.isalpha() and isinstance(name, str)


    @staticmethod
    def valid_phonenr(phone_nr):
        if len(phone_nr) != 10 or not phone_nr.isnumeric() or phone_nr[0]!='0':
            return False
        else:
            return True

    def valid_person(self, person):
        errors=[]
        if not self.valid_id(person.id):
            errors.append("Invalid id for person")
        if not self.valid_name(person.name):
            errors.append("Invalid name for person")
        if not self.valid_phonenr(person.phone_nr):
            errors.append("Invalid phone number for person")
        if len(errors)>0:
            raise PersonValidationException(errors)




class Person:
    def __init__(self, person_id, name, phone_number):
        if not isinstance(person_id, int):
            raise PersonException("Invalid id!")
        if not isinstance(name, str):
            raise PersonException("Invalid name!")
        if not isinstance(phone_number, str):
            raise PersonException("Invalid phone number!")
        self._id = person_id
        self._name = name
        self._phone_nr = phone_number


    @property
    def id(self):
        return self._id

    @property
    def name(self):
        return self._name

    @property
    def phone_nr(self):
        return self._phone_nr

    def __str__(self):
        return str(" id: "+  str(self._id) +"  name: "+ self._name + "  phone number: "+self.phone_nr)

