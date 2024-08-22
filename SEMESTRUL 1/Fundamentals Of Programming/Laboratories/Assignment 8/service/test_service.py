import unittest

from src.domain.activity import Activity, ActivityValidator
from src.domain.person import Person, PersonValidator
from src.repository.activity_repo import ActivityRepo, ActivityRepoExceptions
from src.repository.person_repo import PersonRepo, PersonRepoException

from src.services.activity_services import ActivityService
from src.services.person_services import PersonService


class TestPersonService(unittest.TestCase):
    def setUp(self):
        list = [Person(1, 'Ungur Andreea', '0721389973')]
        repo = PersonRepo(list)
        validator = PersonValidator()
        self._service = PersonService(repo, validator)
        self._service.add(2, 'Ispas Petru', '0733564275')

    def test_add(self):
        self.assertEqual(len(self._service),2)
        self._service.add(3, 'Iulia Maria','0723456789')
        self.assertEqual(len(self._service),3)
        self.assertRaises(PersonRepoException,self._service.add,3, 'Iulia Maria','0723456789')


    def test_remove(self):
        self._service.remove(2)
        self.assertEqual(len(self._service),1)
        self.assertRaises(PersonRepoException,self._service.remove,2)

    def test_update(self):
        self._service.update(2, 'Ispas Petru', '0733564265')
        self.assertEqual(len(self._service),2)
        self.assertRaises(PersonRepoException,self._service.update,3, 'Ispas Petru', '0733564275')

    def test_search_name(self):
        list = self._service.search_name("Ungur Andreea")
        self.assertEqual(len(list), 1)
        self.assertRaises(PersonRepoException, self._service.search_name, "Mihai")

    def test_search_phone(self):
        list = self._service.search_phone("07")
        self.assertEqual(len(list), 2)
        self.assertRaises(PersonRepoException, self._service.search_phone, "075")

    def tearDown(self):
        print('TORN DOWN')


class TestActivityService(unittest.TestCase):
    def setUp(self):
        list = [Activity(1, [1, 2, 3], '2023-10-14', '16:40','17:40', 'dance classes'),Activity(2, [1, 2, 3], '2023-10-14', '12:40', '13:40', 'dance classes'),Activity(3,[1,2,3],'2023-12-20','12:20','13:20','sport'),Activity(4,[1,3],'2023-12-20','12:00','12:19','sport'),Activity(5,[1,3],'2023-12-21','12:00','12:19','sport')]
        list1 = [Person(1, 'Ungur Andreea', '0721389973'), Person(2, 'Culic Maria', '0721439973'),
                 Person(3, 'Stan Ion', '0743289973')]
        repo1 = PersonRepo(list1)
        repo = ActivityRepo(list, repo1)
        validator = ActivityValidator()
        self._service = ActivityService(repo, validator,repo1)
        self._person_repo=repo1

    def test_add(self):
        self.assertEqual(len(self._service), 5)
        self._service.add(Activity(6,[1,2], '2023-12-20', '07:23','08:00','sport'))
        self.assertEqual(len(self._service), 6)
        self.assertRaises(ActivityRepoExceptions, self._service.add, Activity(2,[1,2], '2023-12-20', '07:23','08:00','sport'))

    def test_remove(self):
        self._service.remove(1)
        self.assertEqual(len(self._service), 4)
        self.assertRaises(ActivityRepoExceptions, self._service.remove, 6)

    def test_update(self):
        self._service.update(1, [1, 2], '2023-10-14', '11:41','11:50', 'dance classes')
        self.assertEqual(len(self._service), 5)
        self.assertRaises(ActivityRepoExceptions, self._service.update,6,[1,2], '2030-11-20', '07:23','08:00','sport')

    def test_update_act_repo(self):
        self._service.update_activity_repo()
        self.assertEqual(len(self._service.activities),5)
        self._person_repo.remove_person(1)
        self._service.update_activity_repo()
        self.assertEqual(len(self._service.activities), 5)


    def test_get_all(self):
        self._service.get_all()
        self.assertEqual(len(self._service.activities),5)

    def test_search_date(self):
        list = self._service.search_date_time("2023-10-14", '16:40')
        self.assertEqual(len(list), 1)
        self.assertRaises(ActivityRepoExceptions, self._service.search_date_time, "2023-10-15", '09:20')

    def test_search_desc(self):
        list = self._service.search_description("dance classes")
        self.assertEqual(len(list), 2)


    def test_upcoming_date(self):
        self.assertEqual(self._service.upcoming_dates("2023-12-21",'12:20'),True)
        self.assertEqual(self._service.upcoming_dates("2023-12-31", '12:20'), True)
        self.assertEqual(self._service.upcoming_dates("2023-12-31", '12:20'), True)
        self.assertEqual(self._service.upcoming_dates("2023-11-21", '12:20'), False)
        self.assertEqual(self._service.upcoming_dates("2023-11-30", '12:20'), False)
        self.assertEqual(self._service.upcoming_dates("2023-12-30", '20:20'), True)
        self.assertEqual(self._service.upcoming_dates("2023-12-01", '23:59'), False)
        self.assertEqual(self._service.upcoming_dates("2023-12-08", '23:59'), False)



    def test_busiest_days(self):
        list=self._service.st_busiest_days()
        self.assertEqual(len(list), 2)

    def test_st_activities_person(self):
        list=self._service.st_activities_with_a_person(2)
        self.assertEqual(len(list),1)

    def test_st_activities_date(self):
        list=self._service.st_activities_for_a_date('2023-10-14')
        self.assertEqual(len(list),2)


    def tearDown(self):
        print('TORN DOWN')