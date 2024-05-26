#pragma once
#include "repository.h"

class Action {

public:

    virtual void executeUndo() = 0;
    virtual void executeRedo() = 0;

};

class AddAction : public Action {

private:
    Repository repository;
    Dog addedDog;

public:
    AddAction(Repository* repository, Dog addedDog);
    void executeUndo() override;
    void executeRedo() override;

};

class DeleteAction : public Action {

private:
    Repository repository;
    Dog deletedDog;

public:
    DeleteAction(Repository* repository, Dog deletedDog);
    void executeUndo() override;
    void executeRedo() override;

};


class UpdateAction : public Action {

private:
    Repository repository;
    Dog oldDog;
    Dog newDog;

public:
    UpdateAction(Repository* repository, Dog oldDog, Dog newDog);
    void executeUndo() override;
    void executeRedo() override;

};


class AddActionUserMode : public Action {

private:
    Repository& repository;
    Repository& user_repository;
    Dog oldDog;
    Dog newDog;

public:
    AddActionUserMode(Repository& repository, Repository& user_repository, Dog oldDog, Dog newDog);
    void executeUndo() override;
    void executeRedo() override;
};

class UpdateActionUserMode : public Action {

private:
    Repository& repository;
    Repository& user_repository;
    Dog oldDogUser;
    Dog newDogUser;
    Dog oldDogAdmin;

public:
    UpdateActionUserMode(Repository& repository, Repository& user_repository, Dog oldDogUser, Dog newDogUser, Dog oldDogAdmin);
    void executeUndo() override;
    void executeRedo() override;

};

class UpdateActionDeletedUserMode : public Action {

private:
    Repository& repository;
    Repository& user_repository;
    Dog oldDogUser;
    Dog newDogUser;
    Dog oldDogAdmin;

public:
    UpdateActionDeletedUserMode(Repository& repository, Repository& user_repository, Dog oldDogUser, Dog newDogUser, Dog oldDogAdmin);
    void executeUndo() override;
    void executeRedo() override;

};

class AddDeleteActionUserMode : public Action {

private:
    Repository& repository;
    Repository& user_repository;
    Dog oldDog;
    Dog newDog;

public:
    AddDeleteActionUserMode(Repository& repository, Repository& user_repository, Dog oldDog, Dog newDog);
    void executeUndo() override;
    void executeRedo() override;

};