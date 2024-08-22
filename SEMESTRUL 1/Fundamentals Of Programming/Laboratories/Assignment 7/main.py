from src.ui.ui import *
import unittest
import configparser

if __name__ == "__main__":
    config = configparser.RawConfigParser()
    config.read('config.properties')
    rep = config.get('RepositorySection', 'repository.name')
    filename = config.get('RepositorySection', f'repository.filename_for_{rep.lower()}')

    ui = UI(rep, filename)
    ui.start()