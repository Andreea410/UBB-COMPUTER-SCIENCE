#pragma once
#include "Service.h"
#include <iostream>
#include <string>
#include <vector>
using namespace std;
//#include "DogValidator.h"

class UI
{
private:
	Service service;
public:
	UI(Service serv);
	void run();
	int login();
	void isNumber(const string& str);
	int runManagerUi();
	int runUserUI();
	int readIntegerNumber(const char* message);
	void displayAdminMenu();
	void addAdminUI();
	void updateAdminUI();
	void displayAdminUI();
	void removeAdminUI();
	void displayUserMenu();
	void adoptDog(Dog dog);
	void displayAllDogs();
	string getbreed();
	void displayDogsOfBreed();
	void displayAdoptedDogs();
	int getUserOption();
	void displayOptionsAdoption();



};

