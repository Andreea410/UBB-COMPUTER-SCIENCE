from src.domain.activity import Activity
from src.domain.person import Person
from src.repository.undo_redo import Undo
from src.services.activity_service import ActivityService
from src.services.person_services import PersonService



class UI:
    def __init__(self, person_service: PersonService, activity_service: ActivityService,undo: Undo):
        self._person_service = person_service
        self._activity_service = activity_service
        self._undo=undo

    def list_persons(self):
        if len(self._person_service) > 0:
            for person in self._person_service.persons:
                print(str(person))
        else:
            print("There are no persons in the list!")

    def list_activities(self):
        if len(self._activity_service) > 0:
            for act in self._activity_service.get_all():
                print(str(act))
        else:
            print("There are no activities!")

    def list_act_person(self,person_id):
        if len(self._activity_service.st_activities_with_a_person(person_id)) == 0:
            print("No upcoming activities with this person")
        else:
            print(f"Upcoming activities with the person with given id  are: ")
            for i in self._activity_service.st_activities_with_a_person(person_id):
                print(i)

    def list_act_dates(self,date):
        if len(self._activity_service.st_activities_for_a_date(date)) == 0:
            print("No activities in this date")
        else:
            print(f"The activities for the date {date} are: ")
            for i in self._activity_service.st_activities_for_a_date(date):
                print(i)

    def list_busy(self):
        if len(self._activity_service.st_busiest_days()) == 0:
            print("No upcoming busy days")
        else:
            print(f"Upcoming busy days are: ")
            for i in self._activity_service.st_busiest_days():
                print ('\033[35m'+str(i.date)+'\033[0m')

    def list_search_name(self,name):
        for i in self._person_service.search_name(name):
            print(i)

    def list_search_phone(self, phone):
        for i in self._person_service.search_phone(phone):
            print(i)

    def list_search_date(self, date,time):
        for i in self._activity_service.search_date_time(date,time):
            print(i)

    def list_search_desc(self,desc):
        for i in self._activity_service.search_description(desc):
            print(i)

    def undo(self):
        try:
            self._undo.undo()
        except ValueError:
            raise ValueError("No more undos")

    def redo(self):
        try:
            self._undo.redo()
        except ValueError:
            raise ValueError("No more redos")


    def print_menu(self):
        print('\n')
        print('1: Add a person or an activity')
        print('2: Remove a person or an activity')
        print('3: Update a person or an activity')
        print('4: Display the persons or the activity')
        print('5: Search a person or an activity')
        print("6: Statistics")
        print("7: Undo/Redo")
        print('0: Exit')

    def start_ui(self):
        done = False
        while not done:
            self.print_menu()
            cmd = input("Enter a command: ")
            print('\n')
            try:
                if cmd == '1':
                    print("a. Add a person")
                    print("b. Add an activity\n")
                    cmd2=input("Enter a subcommand: ")
                    if cmd2=='a':
                        id = int(input("Enter the id of the new person: "))
                        name=input("Enter the name of the new person: ")
                        phone_nr=input("Enter the phone number of the new person: ")
                        self._person_service.add( id,name,phone_nr)
                    elif cmd2 == 'b':
                        act_id=int(input("Enter the id of the new activity:"))
                        persons=[]
                        nr=int(input("How many persons take part in the activity?: "))
                        i=0
                        while i<nr:
                            p=int(input("Enter the id of the person: "))
                            persons.append(p)
                            i=i+1
                        date=input("Enter the date of the new activity: ")
                        start_time=input("Enter the start time of the new activity: ")
                        end_time = input("Enter the end time of the new activity: ")
                        desc=input("Enter a short description of the activity: ")
                        self._activity_service.add(Activity(act_id,persons,date,start_time,end_time,desc))
                    else:
                        print("Bad command!")
                elif cmd=='2':
                    print("a. Remove a person")
                    print("b. Remove an activity\n")
                    cmd2 = input("Enter a subcommand: ")
                    if cmd2=='a':
                        id = int(input("Enter the id of the person that you want to delete: "))
                        self._person_service.remove(id)
                    elif cmd2=='b':
                        id=int(input("Enter the id of the activity that you want to delete: "))
                        self._activity_service.remove(id)
                    else:
                        print("Bad command!")
                elif cmd=='3':
                    print("a. Update a person")
                    print("b. Update an activity\n")
                    cmd2 = input("Enter a subcommand: ")
                    if cmd2 == 'a':
                        id = int(input("Enter the id of the person: "))
                        name = input("Enter the new name of the person: ")
                        phone_nr = input("Enter the new phone number of the person: ")
                        self._person_service.update(id,name,phone_nr)
                    elif cmd2== 'b':
                        id = int(input("Enter the id of the activity: "))
                        persons = []
                        nr = int(input("How many persons take part in the activity?: "))
                        i = 0
                        while i < nr:
                            p = int(input("Enter the id of the person: "))
                            persons.append(p)
                            i = i + 1
                        date = input("Enter the new date of the activity: ")
                        start_time = input("Enter the new start time of the activity: ")
                        end_time = input("Enter the new end time of the activity: ")
                        desc = input("Enter a new short description of the activity: ")
                        self._activity_service.update(id, persons, date, start_time,end_time, desc)
                    else :
                        print("Bad command!")
                elif cmd=='4':
                    print("a. Display the persons")
                    print("b. Display the activities\n")
                    cmd2 = input("Enter a subcommand: ")
                    if cmd2=='a':
                        self.list_persons()
                    elif cmd2=='b':
                        self.list_activities()
                    else :
                        print("Bad command!")
                elif cmd=='5':
                    print("a. Search a person ")
                    print("b. Search an activity\n")
                    cmd2 = input("Enter a subcommand: ")
                    if cmd2=='a':
                        print("a. Search a person by name ")
                        print("b. Search a person by phone nr\n")
                        cm3 = input("Enter a subcommand: ")
                        if cm3 == 'a':
                            name = input("Enter the name of the person that you want to find: ")
                            self.list_search_name(name)
                        elif cm3=='b':
                            phone_nr=input("Enter the phone number of the person that you want to find: ")
                            self.list_search_phone(phone_nr)
                        else:
                            print("bad command!")
                    elif cmd2=='b':
                        print("a. Search an activity by date and time ")
                        print("b. Search an activity by description\n")
                        cm3 = input("Enter a subcommand: ")
                        if cm3=='a':
                            date=input("Enter the date of the activity that you want to find: ")
                            time=input("Enter the start time of the activity that you want to find: ")
                            self.list_search_date(date,time)
                        elif cm3=='b':
                            desc=input("Enter the description of the activity that you want to find: ")
                            self.list_search_desc(desc)
                        else:
                            print("Bad command")
                    else:
                      print("Bad command")
                elif cmd=='6':
                    print("a. List the activities for a given date ")
                    print("b. Busiest days")
                    print("c. List all upcoming activities to which a given person will participate.\n")
                    cmd2 = input("Enter a subcommand: ")
                    if cmd2=='a':
                        given_date=input("Enter the date for the activities: ")
                        print('\n')
                        self.list_act_dates(given_date)
                    elif cmd2=='b':
                        self.list_busy()
                    elif cmd2 == 'c':
                        id=int(input("Enter the id of the person: "))
                        print('\n')
                        self.list_act_person(id)
                    else:
                        print("Bad command!")
                elif cmd=='7':
                    print("a. Undo an operation")
                    print("b. Redo an operation\n")
                    cmd2 = input("Enter a subcommand: ")
                    if cmd2 == 'a':
                        self.undo()
                    elif cmd2 == 'b':
                        self.redo()
                    else:
                        print("Bad command!")
                elif cmd == '0':
                    done = True
                    print("Now exiting...")
                else:
                    print("Bad command!")
            except Exception as ex:
                print('\n'+str(ex))




