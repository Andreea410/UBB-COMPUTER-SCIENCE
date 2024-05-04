#pragma once
#include "Service.h"

class UserUI {
private:
	Service& service;
public:
	UserUI(Service& service) : service(service) {}
	~UserUI();
	bool isNumber(const string &str);
	void displayMenu();
	void displayOptionsAdoption();
	void displayAllDogs();  
	string getBreed();
	void displayDogsOfBreed();
	void displayAdoptedDogs();
	void adoptDog(Dog dog);
	void runUserUI();
	int getUserOption();
};