
import datetime
class ActivityException(Exception):
    def __init__(self, msg):
        self._msg = msg

class ActivityValidator:
    @staticmethod
    def valid_id(activity_id):
        if activity_id < 1 or not isinstance(activity_id, int):
            return False
        return True

    @staticmethod
    def valid_persons_ids(person_ids):
        for i in range(len(person_ids)):
            if person_ids[i] < 1 or not isinstance(person_ids[i], int):
                return False
        return True

    @staticmethod
    def valid_description(description):
        if not isinstance(description,str):
            return False
        return True

    @staticmethod
    def valid_date(date):
        if not len(str(date)) == 10 and not str(date)[0] != '0' and not str(date)[0:4] != '0000' and not str(date)[4] == '-' and not str(date)[7] == '-' \
               and not str(date)[5:7] != '00' and not str(date)[8:] != '00':
            return False
        if str(date)[5:7] in ['04','06','09','1 1']:
            if int(str(date)[8:]) > 30:
                return False
        elif str(date)[5:7] =='02':
            if int(str(date)[8:]) > 29:
                return False
        elif str(date)[5:7] in ['01','03','05','07','08','10','12']:
            if int(str(date)[8:]) > 31:
                return False
        else:
            return False

        return True

    @staticmethod
    def valid_time(time):
        return len(str(time)) == 5 and int(str(time)[0:2]) < 24 and int(str(time)[3:5]) < 60

    @staticmethod
    def valid_end_time(start_time,end_time):
        if int(start_time[0:2]) > int(end_time[0:2]):
            return False
        elif int(start_time[0:2]) == int(end_time[0:2]):
            if int(start_time[3:]) > int(end_time[3:]):
                return False
        return True


    def valid_activity(self,activity):
        errors=[]
        if not self.valid_id(activity.activity_id):
            errors.append("Invalid activity id!")
        if not self.valid_persons_ids(activity.person_ids):
            errors.append("Invalid persons ids!")
        if not self.valid_date(activity.date):
            errors.append("Invalid date!")
        if not self.valid_time(activity.start_time):
            errors.append("Invalid start time!")
        if not self.valid_time(activity.end_time):
            errors.append("Invalid end time!")
        if not self.valid_end_time(activity.start_time,activity.end_time):
            errors.append("Invalid end time")
        if not self.valid_description(activity.description):
            errors.append("Invalid activity description!")
        if len(errors)>0:
            raise ActivityExceptionValidator(errors)


class ActivityExceptionValidator(ActivityException):
    def __init__(self,errors):
        self._errors=errors
    def __str__(self):
        result=''
        for er in self._errors:
            result+=er
            result+='\n'
        return result


class Activity:
    def __init__(self, activity_id, person_ids, date, start_time, end_time, description):
        if not isinstance(activity_id, int):
            raise ActivityException("Invalid activity id!")
        if not isinstance(description, str):
            raise ActivityException("Invalid description!")
        for i in range(len(person_ids)):
           if not isinstance(person_ids[i], int):
                raise ActivityException("Invalid person id!")
        if not isinstance(date, str):
            raise ActivityException("Invalid date!")
        if not isinstance(start_time, str):
            raise ActivityException("Invalid time!")
        if not isinstance(end_time, str):
            raise ActivityException("Invalid time!")

        self._activity_id=activity_id
        self._person_ids=person_ids
        self._date=date
        self._start_time=start_time
        self._end_time = end_time
        self._description=description

    @property
    def activity_id(self):
        return self._activity_id

    @property
    def person_ids(self):
        return self._person_ids

    @property
    def date(self):
        return self._date

    @property
    def start_time(self):
        return self._start_time

    @property
    def end_time(self):
        return self._end_time

    @property
    def description(self):
        return self._description

    def __str__(self):
        return " activity id: " + str(self._activity_id) + " persons ids: "+str(self.person_ids)+"  date: "+self._date + "  start time: "+ self._start_time+ "  end time: "+ self._end_time+ "  description: "+self._description