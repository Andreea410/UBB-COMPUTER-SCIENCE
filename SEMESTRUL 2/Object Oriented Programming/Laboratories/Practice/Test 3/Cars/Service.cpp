#include "Service.h"

Repository Service::getRepo()
{
	return this->repo;

}

Service::Service()
{
	this->generateCars();
}

Service::~Service()
{
}

void Service::addCar(Car car)
{
	this->repo.addCar(car);
}

vector<Car> Service::filterCarsByName(string name)
{
	return this->repo.filterCarsByName(name);
}

void Service::generateCars()
{
	this->repo.addCar(Car("Dacia", "Logan", 2010, "black"));
	this->repo.addCar(Car("Dacia", "Sandero", 2015, "white"));
	this->repo.addCar(Car("Dacia", "Duster", 2018, "red"));
	this->repo.addCar(Car("Ford", "Fiesta", 2012, "blue"));
	this->repo.addCar(Car("Ford", "Focus", 2017, "green"));
	this->repo.addCar(Car("Ford", "Mondeo", 2019, "yellow"));
	this->repo.addCar(Car("Audi", "A3", 2014, "black"));
}