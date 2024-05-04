#pragma once
#include "Dog.h"
#include "Repository.h"
#include "DogValidator.h"

class Service {
private:
	Repository* repository;
	DogValidator validator;

public:
	
	Service(Repository* repository, string filename);
	Service() {};
	~Service();
	Repository* getRepo();
	void addAdmin(const Dog& dog);
	void removeAdmin(Dog dog);
	void updateAdmin(Dog dog, Dog newDog);
	void generate();

	void addUser(Dog dog);

};