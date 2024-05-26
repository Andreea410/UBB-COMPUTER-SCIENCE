
#include "Action.h"

AddAction::AddAction(Repository* repository, Dog addedDog) : repository{ *repository }, addedDog{ addedDog } {}

DeleteAction::DeleteAction(Repository* repository, Dog deletedDog) : repository{ *repository }, deletedDog{ deletedDog } {
}

UpdateAction::UpdateAction(Repository* repository, Dog oldDog, Dog newDog) : repository{ *repository }, oldDog{ oldDog }, newDog{ newDog } {}


void AddAction::executeUndo() {
    this->repository.removeAdmin(addedDog);
}

void AddAction::executeRedo() {
    this->repository.addAdmin(addedDog);
}


void DeleteAction::executeUndo() {
    this->repository.addAdmin(deletedDog);
}

void DeleteAction::executeRedo() {
    this->repository.removeAdmin(deletedDog);
}



void UpdateAction::executeUndo() {
    this->repository.updateAdmin(newDog,oldDog);
}

void UpdateAction::executeRedo() {
    this->repository.updateAdmin(oldDog,newDog);
}
