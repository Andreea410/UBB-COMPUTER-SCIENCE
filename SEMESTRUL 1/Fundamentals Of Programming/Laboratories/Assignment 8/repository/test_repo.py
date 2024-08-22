import unittest

from src.domain.activity import Activity
from src.domain.person import Person
from src.repository.activity_repo import ActivityRepo, ActivityRepoExceptions
from src.repository.person_repo import PersonRepo, PersonRepoException


class TestPersonRepo(unittest.TestCase):
    def setUp(self):
        person_list=[Person(1,'Arion Horatiu','0721389973')]
        self._repo=PersonRepo(person_list)
        self._repo.add_person(2,'Vancea Adelin', '0733564275')

    def test_repo_add(self):
        self.assertEqual(len(self._repo),2)
        self.assertRaises(PersonRepoException, self._repo.add_person,1,'Arion Horatiu','0721389973')
        self._repo.add_person(3,'Vancea Adelin', '0735768285')
        self.assertEqual(len(self._repo),3)

    def test_repo_remove(self):
        self._repo.remove_person(2)
        self.assertRaises(PersonRepoException,self._repo.remove_person,3)
        self.assertEqual(len(self._repo),1)

    def test_repo_update(self):
        self._repo.update_person(2,'Maier Luana', '0734564275')
        self.assertEqual(len(self._repo),2)
        self.assertRaises(PersonRepoException,self._repo.update_person,3,'Ispas Petru','0786345678')

    def test_person_in_list(self):
        self.assertTrue(self._repo.person_in_list(1))
        self.assertFalse(self._repo.person_in_list(3))

    def test_get_ids(self):
        list=self._repo.get_ids()
        self.assertEqual(list,[1,2])

    def test_person(self):
        self.assertEqual(len(self._repo.persons),2)

    def test_get_first_name(self):
        self.assertEqual(self._repo.get_firstname("Ispas Petru"),"Petru")

    def test_get_second_name(self):
        self.assertEqual(self._repo.get_secondname("Ispas Petru"),"Petru")

    def test_search_by_name(self):
        list=self._repo.search_by_name("Iulia")
        self.assertEqual(len(list),1)
        self.assertRaises(PersonRepoException,self._repo.search_by_name,"mihai")

    def test_search_by_phone(self):
        list = self._repo.search_by_phone("07")
        self.assertEqual(len(list), 2)
        self.assertRaises(PersonRepoException, self._repo.search_by_phone, "075")

    def test_search_by_id(self):
        person=self._repo.search_by_id(1)
        self.assertEqual(person.id,1)
        self.assertEqual(person.name,'Chereji Iulia')
        self.assertEqual(person.phone_nr,'0721389973')
        self.assertRaises(PersonRepoException,self._repo.search_by_id,5)

    def tearDown(self):
        print('TORN DOWN')




class TestActivityRepo(unittest.TestCase):
    def setUp(self) :
        list = [Activity(1, [1, 2, 3], '2020-10-14', '16:40','17:40', 'dance classes'),Activity(2,[1,2,3],'2020-02-08','12:20','13:00','shopping')]
        list1 = [Person(1, 'Chereji Iulia', '0721389973'), Person(2, 'Culic Maria', '0721439973'),
                 Person(3, 'Stan Ion', '0743289973')]
        repo1 = PersonRepo(list1)
        self._repo = ActivityRepo(list, repo1)

    def test_add_activity(self):
        self.assertEqual(len(self._repo),2)
        self._repo.add_activity(Activity(3,[1,2],'2020-09-08','12:20','13:00','shopping'))
        self.assertEqual(len(self._repo),3)
        self.assertRaises(ActivityRepoExceptions,self._repo.add_activity,Activity(2,[1,2,3],'2020-02-08','12:20','13:00','shopping'))
        self.assertRaises(ActivityRepoExceptions,self._repo.add_activity,Activity(4,[1,2,3],'2020-10-14','12:20','17:00','shopping'))
        self.assertRaises(ActivityRepoExceptions, self._repo.add_activity, Activity(4, [1, 2, 5], '2020-02-08', '12:20', '13:00', 'shopping'))

    def test_delete_activity(self):
        self._repo.remove_activity(2)
        self.assertRaises(ActivityRepoExceptions,self._repo.remove_activity,3)
        self.assertEqual(len(self._repo),1)

    def test_update_activity(self):
        self._repo.update_activity(2,[1,2],'2020-09-08','12:20','13:00','sleeping')
        self.assertEqual(len(self._repo),2)
        self.assertRaises(ActivityRepoExceptions, self._repo.update_activity,3,[1,2],'2020-09-08','12:20','13:00','shopping')
        self.assertRaises(ActivityRepoExceptions, self._repo.update_activity,1, [1, 0, 3], '2020-10-14', '12:20', '12:30', 'shopping')
        #self.assertRaises(ActivityRepoExceptions, self._repo.update_activity, 1, [1, 2, 3], '2020-10-14', '12:20', '17:30', 'shopping')

    def test_unique_time(self):
        self.assertEqual(self._repo.unique_time("8:00","8:30",'2020-02-08'),True)
        self.assertEqual(self._repo.unique_time("16:40", "17:40", '2020-10-14'),False)

    def test_overlap(self):
        act1=Activity(1, [1, 2, 3], '2020-02-08', '11:40','17:40', 'dance classes')
        act2=Activity(2,[1,2,3],'2020-02-08','12:20','13:00','shopping')
        self.assertEqual(self._repo.overlap(act1,act2),True)

        act1 = Activity(1, [1, 2, 3], '2020-02-08', '11:40', '12:40', 'dance classes')
        act2 = Activity(2, [1, 2, 3], '2020-02-08', '12:20', '13:00', 'shopping')
        self.assertEqual(self._repo.overlap(act1, act2), True)

        act1 = Activity(1, [1, 2, 3], '2020-02-08', '13:40', '17:40', 'dance classes')
        act2 = Activity(2, [1, 2, 3], '2020-02-08', '12:20', '14:00', 'shopping')
        self.assertEqual(self._repo.overlap(act1, act2), True)

        act1 = Activity(1, [1, 2, 3], '2020-02-08', '13:40', '17:40', 'dance classes')
        act2 = Activity(2, [1, 2, 3], '2020-02-08', '12:20', '13:50', 'shopping')
        self.assertEqual(self._repo.overlap(act1, act2), True)

        act1 = Activity(1, [1, 2, 3], '2020-02-08', '12:40', '17:40', 'dance classes')
        act2 = Activity(2, [1, 2, 3], '2020-02-08', '12:20', '13:00', 'shopping')
        self.assertEqual(self._repo.overlap(act1, act2), True)

        act1 = Activity(1, [1, 2, 3], '2020-02-08', '12:20', '12:50', 'dance classes')
        act2 = Activity(2, [1, 2, 3], '2020-02-08', '12:40', '13:00', 'shopping')
        self.assertEqual(self._repo.overlap(act1, act2), True)

        act1 = Activity(1, [1, 2, 3], '2020-02-08', '12:40', '12:50', 'dance classes')
        act2 = Activity(2, [1, 2, 3], '2020-02-08', '12:20', '12:50', 'shopping')
        self.assertEqual(self._repo.overlap(act1, act2), True)


    def test_search_by_id(self):
        activity=self._repo.search_by_id(1)
        self.assertEqual(activity.activity_id,1)
        self.assertEqual(activity.person_ids,[1,2,3])
        self.assertEqual(activity.date,'2020-10-14')
        self.assertEqual(activity.start_time, '16:40')
        self.assertEqual(activity.end_time, '17:40')
        self.assertEqual(activity.description, 'dance classes')
        self.assertRaises(ActivityRepoExceptions,self._repo.search_by_id,10)

    def test_search_date_time(self):
        list = self._repo.search_by_date_time("2020-10-14",'16:40')
        self.assertEqual(len(list), 1)
        self.assertRaises(ActivityRepoExceptions, self._repo.search_by_date_time, "2020-10-15",'09:20')

    def test_search_desc(self):
        list = self._repo.search_by_description("dance classes")
        self.assertEqual(len(list), 1)
        self.assertRaises(ActivityRepoExceptions, self._repo.search_by_description, "sportt")

    def tearDown(self):
        print('TORN DOWN')


