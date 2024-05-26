#pragma once
#include "domain.h"
#include <string>
#include <vector>
using namespace std;

class Repository
{
private:
	vector<Car> cars;
public:
	Repository();
	~Repository();
	void addCar(Car car);
	void deleteCar(Car car);
	void updateCar(Car car , Car newCar);
	vector<Car> getCars();
	vector<Car> filterCarsByName(string name);
};

