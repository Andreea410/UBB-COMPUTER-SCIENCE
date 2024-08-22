
from src.ui.ui import UI
from src.domain.activity import ActivityValidator, Activity
from src.domain.person import PersonValidator, Person
import random
from datetime import date

from src.repository import person_text_repo
from src.repository.activity_binary_repo import ActivityBinaryRepo
from src.repository.activity_text_repo import ActivityTextFileRepository
from src.repository.person_binary_repo import PersonBinaryRepo
from src.repository.person_text_repo import PersonTextFileRepository
from src.start.settings import Settings

from src.repository.activity_repo import ActivityRepo
from src.repository.person_repo import PersonRepo
from src.repository.undo_redo import Undo
from src.services.activity_service import ActivityService
from src.services.person_services import PersonService
from src.repository import activity_text_repo


def create_persons_list():
    persons = []
    firstname_list = ['Andreea', 'Mario', 'Alina', 'Marius', 'Petru', 'Nicola', 'Casiana', 'Alexandra', 'Ioana',
                'Catalin', 'Luana', 'Mario', 'Carmen', 'Florin', 'George', 'Andrei', 'Mihnea']

    surname_list = ['Ungur', 'Maxim', 'Ispas', 'Mago', 'Chirica', 'Voda', 'Maier', 'Tomas', 'Andone','Popa'
               'Ripan', 'Opre', 'Ardelean', 'Micu', 'Vancea', 'Arion', 'Strugari']
    persons_ids = []
    for i in range(1, 21):
        persons_ids.append(i)

    for i in range(20):
        id = random.choice(persons_ids)
        persons_ids.remove(id)
        firstname = random.choice(firstname_list)
        surname = random.choice(surname_list)
        name = firstname + ' ' + surname
        phone_number = '0'
        for i in range(9):
            digit = random.randint(0, 9)
            phone_number += str(digit)
        persons.append(Person(id, name, phone_number))
    return persons


def create_activity_list():
    activity = []
    possible_activities = ["cooking", "dance classes", "sleeping", "going for a walk", "learning", "going out",
                         "online classes", "shopping", "eating", "visiting a friend", "reading", "watching a movie",
                         "meeting", "sport"]
    activity_ids = []
    for i in range(1, 11):
        activity_ids.append(i)
    for i in range(10):
        id_act = random.choice(activity_ids)
        activity_ids.remove(id_act)
        person_list = []
        for j in range(1, 6):
            persons_id = random.randint(1, 10)
            ok = 0
            for t in person_list:
                if t == persons_id:
                    ok = 1
            if ok == 0:
                person_list.append(persons_id)
        start_date = date.today().replace(day=1, month=1).toordinal()
        end_date = date.today().replace(year=2024).toordinal()
        date_act = date.fromordinal(random.randint(start_date, end_date))
        hour = random.randint(0, 22)
        chour=hour
        if hour<10:
            hour='0'+str(hour)
        minutes = random.randint(0, 58)
        cmin=minutes
        if minutes < 10:
            minutes='0'+str(minutes)
        start_time = str(hour)+":"+str(minutes)
        hour1 = random.randint(chour, 23)
        if hour1 < 10:
            hour1 = '0' + str(hour1)
        minutes1 = random.randint(cmin, 59)
        if minutes1 < 10:
            minutes1 = '0' + str(minutes1)
        end_time = str(hour1) + ":" + str(minutes1)
        description = random.choice(possible_activities)
        activity.append(Activity(id_act, person_list, str(date_act), start_time,end_time, description))
    return activity


settings = Settings()
person_validator = PersonValidator()
activity_validator = ActivityValidator()
undo = Undo()

if settings.typeofrepo == 'inmemory':
    person_repo = PersonRepo(create_persons_list())
    person_service = PersonService(person_repo, person_validator, undo)
    activity_repo = ActivityRepo(create_activity_list())
    activity_service = ActivityService(activity_repo, activity_validator, undo, person_repo)
elif settings.typeofrepo =="text file":
    p_repo= PersonTextFileRepository(settings.person_repo)
    activity_repo = ActivityTextFileRepository(settings.activity_repo)
    person_service = PersonService(p_repo, person_validator, undo)
    activity_service = ActivityService(activity_repo, activity_validator, undo, p_repo)
elif settings.typeofrepo == "binary file":
    person_repo = PersonBinaryRepo(settings.person_repo)
    activity_repo = ActivityBinaryRepo(settings.activity_repo)
    person_service = PersonService(person_repo, person_validator, undo)
    activity_service = ActivityService(activity_repo, activity_validator,undo,person_repo)

if settings.menu == "ui":
    ui = UI(person_service, activity_service, undo)
    ui.start_ui()