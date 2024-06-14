#include "Service.h"

using namespace std;
Engine* Service::createEngine(string engineType, string fuelType, int autonomy)
{
	Engine* engine = nullptr;
	if (engineType == "Electric")
		engine = new ElectricEngine(fuelType, autonomy);
	if (engineType == "Turbo")
		engine = new TurboEngine(fuelType);
	return engine;
}

Car Service::getLastAddedCar()
{
	return this->cars.back();
}

void Service::generateEntries()
{
	this->cars.push_back(Car("Sedan", this->createEngine("Electric", "Electric", 6000)));
	this->cars.push_back(Car("Convertible", this->createEngine("Electric", "Electric", 15000)));
	this->cars.push_back(Car("Sedan", this->createEngine("Turbo", "Gasoline")));
	this->cars.push_back(Car("Sedan", this->createEngine("Turbo", "Diesel")));
	this->cars.push_back(Car("Convertible", this->createEngine("Turbo", "Gasoline")));
	this->cars.push_back(Car("Convertible", this->createEngine("Turbo", "Diesel")));
}

void Service::addCar(string bodyStyle, string engineType, string fuelType, int autonomy)
{
	Engine* engine = this->createEngine(engineType, fuelType, autonomy);
	this->cars.push_back(Car(bodyStyle, engine));
}

vector<Car> Service::getAll()
{
	return this->cars;
}


vector<Car> Service::getCarsWithMaxPrice(double price)
{
	vector<Car> goodCars;
	for (Car element : cars)
		if (element.computePrice() < price)
			goodCars.push_back(element);
	return goodCars;
}

void Service::writeToFile(string filename ,vector<Car> cars)
{
	ofstream writeToFile(filename);
	for (auto car : cars)
		writeToFile << car.toString() << '\n';
}

