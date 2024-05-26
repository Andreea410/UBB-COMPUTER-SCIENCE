#pragma once
#include "Repository.h"


class Service
{
private:
	Repository repo;
public:
	Service();
	~Service();
	void addCar(Car car);
	Repository getRepo();
	vector<Car> filterCarsByName(string name);
	void generateCars();
};

