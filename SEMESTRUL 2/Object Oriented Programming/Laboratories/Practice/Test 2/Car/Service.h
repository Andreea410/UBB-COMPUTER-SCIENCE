#pragma once
#include "Car.h"
#include <vector>
#include <fstream>

class Service
{
private:
	vector<Car> cars;
	Engine* createEngine(string engineTpe, string fuelType, int autonomy = 0);
public:
	Service() { this->generateEntries(); };
	~Service()
	{
		for (auto car : this->cars)
			car.~Car();
	};
	Car getLastAddedCar();
	void generateEntries();
	void addCar(string bodyStyle, string EngineType,  string fuelType, int autonomy = 0);
	vector<Car> getCarsWithMaxPrice(double maxPrice);
	vector<Car> getAll();
	void writeToFile(string filename , vector<Car>cars);


};

