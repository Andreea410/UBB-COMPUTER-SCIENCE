#include "Repository.h"

Repository::Repository()
{
}

Repository::~Repository()
{
}

void Repository::addCar(Car car)
{
	this->cars.push_back(car);
}

void Repository::deleteCar(Car car)
{
	for (int i = 0; i < this->cars.size(); i++)
	{
		if (this->cars[i].getName() == car.getName() && this->cars[i].getModel() == car.getModel() && this->cars[i].getYear() == car.getYear() && this->cars[i].getColor() == car.getColor())
		{
			this->cars.erase(this->cars.begin() + i);
			break;
		}
	}
}

void Repository::updateCar(Car car, Car newCar)
{
	for (int i = 0; i < this->cars.size(); i++)
	{
		if (this->cars[i].getName() == car.getName() && this->cars[i].getModel() == car.getModel() && this->cars[i].getYear() == car.getYear() && this->cars[i].getColor() == car.getColor())
		{
			this->cars[i] = newCar;
			break;
		}
	}
}

vector<Car> Repository::getCars()
{
	return this->cars;
}

vector<Car> Repository::filterCarsByName(string name)
{
	vector<Car> filteredCars;
	for (int i = 0; i < this->cars.size(); i++)
	{
		if (this->cars[i].getName() == name)
		{
			filteredCars.push_back(this->cars[i]);
		}
	}
	return filteredCars;
}