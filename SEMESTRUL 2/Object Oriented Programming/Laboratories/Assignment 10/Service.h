#pragma once
#include "Dog.h"
#include "Repository.h"
#include <string>
#include "Action.h"
#include "DogValidator.h"
#include <map>

class Service {
private:
    Repository* repository;
    DogValidator validator;
    vector<Action*> undoStackAdminMode;
    vector<Action*> redoStackAdminMode;
public:
    Service(Repository* repository, std::string filename);
    Service() {};
    ~Service();
    Repository* getRepo();
    void addAdmin(const Dog& dog);
    void removeAdmin(const Dog& dog);
    void updateAdmin(const Dog& dog, const Dog& newDog);
    void generate();
    void addUser(const Dog& dog);
    std::map<std::string, int> getMapOfDogsByBreed();
    void open();

    int undoLastAction(std::vector<Action*>& currentUndoStack, std::vector<Action*>& currentRedoStack);
    int redoLastAction(std::vector<Action*>& currentUndoStack, std::vector<Action*>& currentRedoStack);
    int undoAdminMode();

    int redoAdminMode();
};
