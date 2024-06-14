#pragma once
#include "Service.h"
#include "Car.h"

class UI
{
private:
	Service service;
public:
	UI() {};
	~UI() {};
	void displayMenu();
	void run();
	void addCar();
	void displayCars();
	void writeToFile();

};

