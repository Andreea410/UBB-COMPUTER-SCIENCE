
from src.domain.activity import Activity
from src.domain.person import Person
from src.repository.person_repo import PersonRepo
import datetime


class ActivityRepoExceptions(Exception):
    def __init__(self, msg):
        self._msg = msg


class ActivityRepo:
    def __init__(self, activity_list):
        self._activities = activity_list.copy()


    @property
    def activities(self):
        return self._activities


    def get_all(self):
        return self._activities[:]

    def unique_id(self,id):
        """
        checks if a given id is unique
        :param id:
        :return:
        """
        for act in self._activities:
            if act.activity_id == id:
                return False
        return True

    def unique_time(self,start_time, end_time, date):
        """
        checks is the date and time are unique so that activities do not overlap
        :param time:
        :param date:
        :return:
        """
        for act in self._activities:
            if str(act.date) == str(date) and str(act.start_time)==str(start_time) and str(act.end_time)==str(end_time):
                return False
        return True

    def overlap(self,act1:Activity,act2:Activity):
        """
        checks if 2 given activities overlap
        :param act1: activity 1
        :param act2: activity 2
        :return:
        """
        if act1.date==act2.date:
            hs1=int(act1.start_time[0:2])
            ms1=int(act1.start_time[3:])
            hf1=int(act1.end_time[0:2])
            mf1=int(act1.end_time[3:])
            hs2 = int(act2.start_time[0:2])
            ms2 = int(act2.start_time[3:])
            hf2 = int(act2.end_time[0:2])
            mf2 = int(act2.end_time[3:])
            if hs1 < hs2:
                if hf1 > hs2:
                    return True
                elif hf1==hs2:
                    if mf1>ms2:
                        return True
            elif hs1 > hs2:
                if hf2 >hs1:
                    return True
                elif hf2==hs1:
                    if mf2>ms1:
                        return True
            else:
                if hf1>hs2:
                    return True
                elif hf1 == hs2 and ms1<ms2:
                    if mf1 > ms2:
                        return True
                elif hf1 == hs2 and ms1 > ms2:
                    if ms1 < mf2:
                        return True

        return False


    def add_activity(self, act: Activity):
        """
        adds an activity to the repository
        :param act:
        :return:
        """
        if not self.unique_id(act.activity_id):
            raise ActivityRepoExceptions("Duplicate id!")
        ok=True
        ko= True
        for i in self._activities:
            if self.overlap(i,act):
                ko=False
        if self.unique_time(act.start_time,act.end_time, act.date) and ko and ok:
                self._activities.append(act)
        else:
            raise ActivityRepoExceptions("Activities must not overlap!")

    def remove_activity(self, id_remove):
        """
        removes an activity from the repository
        :param id_remove:
        :return:
        """
        ok = True
        i = 0
        while i <= len(self._activities) - 1:
            if self._activities[i].activity_id == id_remove:
                self._activities.pop(i)
                ok = False
            else:
                i = i + 1
        if ok:
            raise ActivityRepoExceptions("The activity with the given id doesn't exist!")

    def update_activity(self,act_id,person_ids,date,start_time,end_time,desc):
        """
        updates an activity from the repository
        :param activity:
        :return:
        """

        ok = True
        activity=Activity(act_id,person_ids,date,start_time,end_time,desc)
        for p in self._activities:
            if act_id == p.activity_id:
                ko = True
                for i in self._activities:
                    if i.activity_id != act_id:
                        if self.overlap(i, activity):
                            ko = False

                if ko and self.unique_time(start_time,end_time, date) :
                    p._date = date
                    p._start_time = start_time
                    p._end_time=end_time
                    p._description = desc
                    p._person_ids=person_ids
                else:
                    raise ActivityRepoExceptions("Activities must not overlap")
                ok = False
        if ok:
            raise ActivityRepoExceptions("The activity to be updated doesn't exist!")

    def search_by_date_time(self,date,start_time):
        """
        searches for activities happening at a given date and time
        :param date:
        :param time:
        :return:
        """
        ok = False
        list=[]
        for activity in self._activities:
            if  activity.date.find(date)!=-1 and activity.start_time.find(start_time)!=-1:
                ok = True
                list.append(activity)
        if not ok:
            raise ActivityRepoExceptions("The activity with the given date and start time is not in the agenda!")
        return list

    def search_by_description(self,desc):
        """
        searches for activities having a given description
        :param desc:
        :return:
        """
        ok = False
        list=[]
        for activity in self._activities:
            if activity.description.lower().find(desc.lower())!=-1:
                ok = True
                list.append(activity)
        if not ok:
            raise ActivityRepoExceptions("The activity with the given description is not in the agenda!")
        return list

    def search_by_id(self,id):
        """
        searches an activity with a given id
        :param id:
        :return:
        """
        ok = False
        for act in self._activities:
            if act.activity_id == id:
                ok = True
                return act
        if not ok:
            raise ActivityRepoExceptions("The activity with the given id is not in the agenda!")

    def __len__(self):
        """
        Returns the length of the repository
        :return:
        """
        return len(self._activities)





