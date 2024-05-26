#include "domain.h"
#include <string>
using namespace std;

Car::Car()
{
	this->name = "";
	this->model = "";
	this->year = 0;
	this->color = "";
}

Car::Car(string name, string model, int year, string color)
{
	this->name = name;
	this->model = model;
	this->year = year;
	this->color = color;
}

string Car::getName()
{
	return this->name;
}

string Car::getModel()
{
	return this->model;
}

int Car::getYear()
{
	return this->year;
}

string Car::getColor()
{
	return this->color;
}

void Car::setName(string name)
{
	this->name = name;
}

void Car::setModel(string model)
{
	this->model = model;
}

void Car::setYear(int year)
{
	this->year = year;
}

void Car::setColor(string color)
{
	this->color = color;
}

bool Car::operator==(const Car& c)
{
	return this->name == c.name && this->model == c.model && this->year == c.year && this->color == c.color;
}

string Car::toString()
{
	return this->name +"|" + this->model + "|" + to_string(this->year) + "|" + this->color;
}