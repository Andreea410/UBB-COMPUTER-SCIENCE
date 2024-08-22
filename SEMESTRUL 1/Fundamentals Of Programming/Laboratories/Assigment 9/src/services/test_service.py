import unittest

from src.domain.activity import Activity, ActivityValidator
from src.domain.person import Person, PersonValidator
from src.repository.activity_repo import ActivityRepo, ActivityRepoExceptions
from src.repository.person_repo import PersonRepo, PersonRepoException
from src.repository.undo_redo import Undo, CascadedOperation, FunctionCall, Operation
from src.services.activity_service import ActivityService
from src.services.person_services import PersonService


class TestPersonService(unittest.TestCase):
    def setUp(self):
        list = [Person(1, 'Ungur Andreea', '0721389973')]
        repo = PersonRepo(list)
        validator = PersonValidator()
        self._undo= Undo()
        self._service = PersonService(repo, validator,self._undo)
        self._service.add(2, 'Mario Maxim', '0733564275')

    def test_add(self):
        self.assertEqual(len(self._service),2)
        self._service.add(3, 'Ispas Petru','0723456789')
        self.assertEqual(len(self._service),3)
        self.assertRaises(PersonRepoException,self._service.add,3, 'Ispas Petru','0723456789')


    def test_remove(self):
        self._service.remove(2)
        self.assertEqual(len(self._service),1)
        self.assertRaises(PersonRepoException,self._service.remove,2)

    def test_update(self):
        self._service.update(2, 'Ispas Petru', '0733564265')
        self.assertEqual(len(self._service),2)
        self.assertRaises(PersonRepoException,self._service.update,3, 'Ispas Petru', '0733564275')

    def test_search_name(self):
        list = self._service.search_name("Andreea")
        self.assertEqual(len(list), 1)
        self.assertRaises(PersonRepoException, self._service.search_name, "mihai")

    def test_search_phone(self):
        list = self._service.search_phone("07")
        self.assertEqual(len(list), 2)
        self.assertRaises(PersonRepoException, self._service.search_phone, "075")

    def tearDown(self):
        print('TORN DOWN')

class TestUndoService(unittest.TestCase):
    def setUp(self):
        list = [Activity(1, [1, 2, 3], '2024-10-14', '16:40', '17:40', 'dance classes'),
                Activity(2, [1, 2, 3], '2024-10-14', '12:40', '13:40', 'dance classes'),
                Activity(3, [1, 2, 3], '2024-12-20', '12:20', '13:20', 'sport'),
                Activity(4, [1, 3], '2024-12-20', '12:00', '12:19', 'sport'),
                Activity(5, [1, 3], '2024-12-21', '12:00', '12:19', 'sport')]
        list1 = [Person(1, 'Ungur Andreea', '0721389973'), Person(2, 'Mario Maxim', '0721439973'),
                 Person(3, 'Szarici Iulia', '0743289973')]
        repo1 = PersonRepo(list1)
        repo = ActivityRepo(list)
        validator = ActivityValidator()
        val1=PersonValidator()
        self._undo = Undo()
        self._service = ActivityService(repo, validator, self._undo, repo1)
        self._pservice= PersonService(repo1,val1,self._undo)
        self._person_repo = repo1
        self._act_repo=repo
        self._u=CascadedOperation()

    def test_undo_redo(self):
        self.assertEqual(len(self._person_repo),3)
        self._pservice.remove(1)
        self.assertEqual(len(self._person_repo), 2)
        self._undo.undo()
        self.assertEqual(len(self._person_repo), 3)
        self._undo.redo()
        try:
            self._undo.redo()
        except ValueError:
            assert True
        self.assertEqual(len(self._person_repo), 2)
        try:
            self._undo.undo()
        except ValueError:
            assert True

    def test_undo(self):
        self._pservice.add(4, 'Arion Horatiu', '0723456789')
        self.assertEqual(self._undo.return_index(),0)
        self._undo.undo()
        self.assertEqual(len(self._pservice),3)
        self._undo.return_last_element()
        self._undo.remove_last_element()
        self.assertEqual(self._undo.return_index(), -2)
        self._pservice.remove(1)

    def test_cascade(self):
        a = Activity(6, [1,2], '2024-10-14', '10:40', '11:40', 'dance classes')
        a2 = Activity(7, [1, 2,3], '2024-10-15', '16:40', '17:40', 'dance classes')
        self._act_repo.add_activity(a)
        self._act_repo.add_activity(a2)
        self._person_repo.remove_person(1)
        self._service.update_activity_repo()
        p=Person(4,'Andreea','0721378993')
        a=Activity(1, [4], '2024-10-14', '16:40', '17:40', 'dance')
        undo_fun1=FunctionCall(self._person_repo.add_person,4,'Andreea','0721378993')
        redo_fun1=FunctionCall(self._person_repo.remove_person,p.id)
        op1=Operation(undo_fun1,redo_fun1)
        undo_fun2 = FunctionCall(self._act_repo.add_activity,a)
        redo_fun2 = FunctionCall(self._act_repo.remove_activity,a)
        op2 = Operation(undo_fun2, redo_fun2)
        co=CascadedOperation(op1,op2)
        self._u.undo()
        self._u.redo()
        self._undo.record(co)
        self.assertEqual(self._undo.separate_last_op()[0],(undo_fun1,redo_fun1))



class TestActivityService(unittest.TestCase):
    def setUp(self):
        list = [Activity(1, [1, 2, 3], '2024-10-14', '16:40','17:40', 'dance classes'),Activity(2, [1, 2, 3], '2020-10-14', '12:40', '13:40', 'dance classes'),Activity(3,[1,2,3],'2021-12-20','12:20','13:20','sport'),Activity(4,[1,3],'2021-12-20','12:00','12:19','sport'),Activity(5,[1,3],'2021-12-21','12:00','12:19','sport')]
        list1 = [Person(1, 'Ungur Andreea', '0721389973'), Person(2, 'Mario Maxim', '0721439973'),
                 Person(3, 'Ispas Petru', '0743289973')]
        repo1 = PersonRepo(list1)
        repo = ActivityRepo(list)
        validator = ActivityValidator()
        undo=Undo()
        self._service = ActivityService(repo, validator,undo,repo1)
        self._person_repo=repo1

    def test_add(self):
        self.assertEqual(len(self._service), 5)
        self._service.add(Activity(6,[1,2], '2020-12-20', '07:23','08:00','sport'))
        self.assertEqual(len(self._service), 6)
        self.assertRaises(ActivityRepoExceptions, self._service.add, Activity(2,[1,2], '2020-12-20', '07:23','08:00','sport'))
        self.assertRaises(ActivityRepoExceptions, self._service.add,Activity(6, [0, 2], '2020-01-20', '03:20', '08:00', 'sleep'))

    def test_remove(self):
        self._service.remove(1)
        self.assertEqual(len(self._service), 4)
        self.assertRaises(ActivityRepoExceptions, self._service.remove, 6)

    def test_update(self):
        self._service.update(1, [1, 2], '2020-10-14', '11:41','11:50', 'dance classes')
        self.assertEqual(len(self._service), 5)
        self.assertRaises(ActivityRepoExceptions, self._service.update,6,[1,2], '2020-11-20', '07:23','08:00','sport')
        self.assertRaises(ActivityRepoExceptions, self._service.update, 6, [0, 2], '2020-11-20', '07:23', '08:00','sport')

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
        list = self._service.search_date_time("2024-10-14", '16:40')
        self.assertEqual(len(list), 1)
        self.assertRaises(ActivityRepoExceptions, self._service.search_date_time, "2024-10-15", '09:20')

    def test_search_desc(self):
        list = self._service.search_description("dance classes")
        self.assertEqual(len(list), 2)
        self.assertRaises(ActivityRepoExceptions, self._service.search_description, "sportt")

    def test_upcoming_date(self):
        self.assertEqual(self._service.upcoming_dates("2024-12-21",'12:20'),True)
        self.assertEqual(self._service.upcoming_dates("2024-12-31", '12:20'), True)
        self.assertEqual(self._service.upcoming_dates("2024-12-31", '12:20'), True)
        self.assertEqual(self._service.upcoming_dates("2024-11-21", '12:20'), True)
        self.assertEqual(self._service.upcoming_dates("2024-11-30", '12:20'), True)
        self.assertEqual(self._service.upcoming_dates("2024-12-30", '20:20'), True)
        self.assertEqual(self._service.upcoming_dates("2024-12-01", '23:59'), True)
        self.assertEqual(self._service.upcoming_dates("2024-12-08", '23:59'), True)



    def test_free_time(self):
        self.assertEqual(self._service.free_time_in_day('2024-10-14'), 1379)


    def test_busiest_days(self):
        list=self._service.st_busiest_days()
        self.assertEqual(len(list), 1)

    def test_st_activities_person(self):
        list=self._service.st_activities_with_a_person(2)
        self.assertEqual(len(list),1)

    def test_st_activities_date(self):
        list=self._service.st_activities_for_a_date('2024-10-14')
        self.assertEqual(len(list),1)


    def tearDown(self):
        print('TORN DOWN')