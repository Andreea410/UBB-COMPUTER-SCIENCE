#pragma once

#include "Dog.h"
#include "ManagerRepository.h"
#include "UserRepository.h"

class Service {
private:
	ManagerRepository& admin_repo;
	UserRepository& user_repo;
public:
	Service(ManagerRepository& adminRepo, UserRepository& userRepo)
		: admin_repo(adminRepo), user_repo(userRepo) {}
	~Service(ManagerRepository& adminRepo, UserRepository& userRepo);
	ManagerRepository getAdminRepo();
	bool addAdmin(const Dog& dog);
	bool removeAdmin(Dog dog);
	bool updateAdmin(Dog dog, Dog newDog);
	void generate();

	UserRepository getUserRepo();
	bool addUser(Dog& dog);
};