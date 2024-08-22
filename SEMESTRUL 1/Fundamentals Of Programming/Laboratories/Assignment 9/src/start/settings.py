class Settings:
    def __init__(self, file_name = 'settings'):
        self._file_name = file_name


    def _load(self):
        f = open(self._file_name,'rt')
        lines = f.readlines()
        f.close()
        dictionary = {}
        for line in lines:
            line = line.split('=')
            dictionary[line[0].strip()] = line[1].strip().strip('\n')
        return dictionary

    @property
    def typeofrepo(self):
        return self._load()['repository'].strip().strip('\n')

    @property
    def person_repo(self):
        return self._load()['persons'].strip().strip('\n')

    @property
    def activity_repo(self):
        return self._load()['activities'].strip().strip('\n')

    @property
    def menu(self):
        return self._load()['menu'].strip().strip('\n')
