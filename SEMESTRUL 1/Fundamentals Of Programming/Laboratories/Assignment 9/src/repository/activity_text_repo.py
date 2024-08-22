from src.domain.activity import Activity
from src.repository.activity_repo import ActivityRepo
from src.repository.person_repo import PersonRepo


class ActivityTextFileRepository(ActivityRepo):
    def __init__(self, file_name='activity.txt'):
        super().__init__([])
        self._file_name = file_name
        self._load()

    def add_activity(self, act):
        super().add_activity(act)
        self._save()

    def get_all(self):
        super().get_all()
        self._save()
        return self.activities[:]

    def remove_activity(self, id_remove):
        super().remove_activity(id_remove)
        self._save()

    def update_activity(self,act_id,person_ids,date,start_time,end_time,desc):
        super().update_activity(act_id,person_ids,date,start_time,end_time,desc)
        self._save()

    def _save(self):
        f = open(self._file_name, 'wt')
        for act in self.activities:
            line = str(act.activity_id) + ';' + str(act.person_ids) + ';'+ str(act.date) + ';' + str(act.start_time) + ';' +str(act.end_time) +';'+str(act.description)
            f.write(line)
            f.write('\n')
        f.close()

    def _load(self):
        """
        Load data from file
        We assume file-saved data is valid
        """
        f = open(self._file_name, 'r')  # read text
        lines = f.readlines()
        f.close()

        for line in lines:
            line = line.split(";")
            pers_list = line[1].replace('[', '')
            pers_list = pers_list.replace(']', '')
            pers_list = pers_list.split(',')
            line[0] = int(line[0])
            for i in range(len(pers_list)):
                pers_list[i]=int(pers_list[i])
            super().add_activity(Activity(line[0], pers_list, line[2], line[3], line[4], line[5]))


