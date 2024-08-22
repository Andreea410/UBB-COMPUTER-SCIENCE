from src.repository.activity_repo import ActivityRepo
import pickle

class ActivityBinaryRepo(ActivityRepo):
    def __init__(self, file_name):
        super().__init__([])
        self._file_name = file_name
        self.read_bin_file()

    def add_activity(self, activity):
        super().add_activity(activity)
        self.write_bin_file()

    def remove_activity(self, activity):
        super().remove_activity(activity)
        self.write_bin_file()

    def get_all(self):
        super().get_all()
        self.write_bin_file()
        return self.activities[:]

    def update_activity(self, activity_id, pers_list, date, start_time, end_time, description):
        super().update_activity(activity_id,pers_list,date,start_time,end_time,description)
        self.write_bin_file()

    def write_bin_file(self):
        f = open(self._file_name, 'wb')
        pickle.dump(self._activities, f)
        f.close()

    def read_bin_file(self):
        result = []
        try:
            f = open(self._file_name, 'rb')
            self._activities = pickle.load(f)
            f.close()
            return self._activities
        except EOFError:
            return result
        except IOError as e:
            raise e