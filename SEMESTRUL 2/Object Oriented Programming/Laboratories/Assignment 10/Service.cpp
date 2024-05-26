#include "Service.h"
#include "Repository.h"
#include <string>
#include <map>
using namespace std;

Service::Service(Repository* repository, const string filename) : repository{ repository }
{}

Service::~Service()
{
}

Repository* Service::getRepo()
{
	return this->repository;
}

void Service::addAdmin(const Dog& dog)
{
	this->validator.validate(dog);
	this->repository->addAdmin(dog);
	Action* currentAction = new AddAction(this->repository, dog);
	this->undoStackAdminMode.push_back(currentAction);
	this->redoStackAdminMode.clear();

}

void Service::removeAdmin(const Dog& dog)
{
	this->validator.validate(dog);
	this->repository->removeAdmin(dog);
	Action* currentAction = new DeleteAction(this->repository, dog);
	this->undoStackAdminMode.push_back(currentAction);
	this->redoStackAdminMode.clear();

}

void Service::updateAdmin(const Dog& dog,const Dog& newDog)
{
	this->validator.validate(dog);
	this->validator.validate(newDog);
	this->repository->updateAdmin(dog, newDog);
	Action* currentAction = new DeleteAction(this->repository, dog);
	this->undoStackAdminMode.push_back(currentAction);
	this->redoStackAdminMode.clear();
}

void Service::generate()
{
	this->repository->addAdmin(Dog("Shitzu", "Jessie", 17, "https://www.akc.org/2017/11/Shih-Tzu-On-White-01.jpg", false));
	this->repository->addAdmin(Dog("Bichon", "Maya", 30, "https://www.akc.org/2017/11/Bichon-On-White.jpg", false));
	this->repository->addAdmin(Dog("Akita", "Lucky", 11, "https://www.akc.org/2017/11/Akita-01.jpg", false));
	/*this->repository.addAdmin(Dog("Terrier", "Tom", 21, "https://www.akc.org/2017/11/Terrier.jpg" , false));
	this->repository.addAdmin(Dog("Catle", "John", 19, "https://www.akc.org/2017/11/Catle-White-01.jpg" , false));
	this->repository.addAdmin(Dog("Sheperd", "Lon", 20, "https://www.akc.org/2017/11/Sheperd-01.jpg", false));
	this->repository.addAdmin(Dog("Barbet", "Terry", 40, "https://www.akc.org//2017/11/Barbet-01.jpg", false));
	this->repository.addAdmin(Dog("Beagle", "Atos", 19, "https://www.akc.org/2017/11/Beagle-01.jpg", false));
	this->repository.addAdmin(Dog("Boxer", "Tommy", 32, "https://www.akc.org/2017/11/Boxer-01.jpg", false));
	this->repository.addAdmin(Dog("Terrie", "Polly", 89, "https://www.akc.org/2017/11/Terrie-01.jpg", false));*/

}

void Service::addUser(const Dog& dog)
{
	this->repository->addUser(dog);
}

std::map<string, int> Service::getMapOfDogsByBreed()
{
	std::map<std::string, int> mapOfDogsByBreed;
	for (const auto& dog : this->repository->getDogs()) {
		std::string breed = dog.getBreed();
		if (mapOfDogsByBreed.find(breed) == mapOfDogsByBreed.end())
			mapOfDogsByBreed[breed] = 1;
		else
			++mapOfDogsByBreed[breed];
	}
	return mapOfDogsByBreed;
}

void Service::open()
{
	this->repository->open();
}

int Service::undoLastAction(vector<Action*>& currentUndoStack, vector<Action*>& currentRedoStack) {
	if (currentUndoStack.empty()) {
		return 1;
	}

	Action* currentAction = currentUndoStack.back();
	currentAction->executeUndo();
	currentRedoStack.push_back(currentAction);
	currentUndoStack.pop_back();
	return 0;
}

int Service::redoLastAction(vector<Action*>& currentUndoStack, vector<Action*>& currentRedoStack) {
	if (currentRedoStack.size() == 0) {
		return 1;
	}

	Action* currentAction = currentRedoStack.back();
	currentAction->executeRedo();
	currentUndoStack.push_back(currentAction);
	currentRedoStack.pop_back();
	return 0;
}

int Service::undoAdminMode() {
	return this->undoLastAction(this->undoStackAdminMode, this->redoStackAdminMode);
}

int Service::redoAdminMode() {
	return this->redoLastAction(this->undoStackAdminMode, this->redoStackAdminMode);
}
