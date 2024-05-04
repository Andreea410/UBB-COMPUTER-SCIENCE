#include "Dog.h"

#include <string>
#include <sstream>

Dog::Dog(string breed, string name, int age, string photograph)
{
	this->breed = breed;
	this->name = name;
	this->age = age;
	this->photograph = photograph;
}

Dog::Dog()
{
	this->breed = "";
	this->name = "";
	this->age = 0;
	this->photograph = "";
}

string Dog::getBreed() const
{
	return this->breed;
}

string Dog::getName() const
{
	return this->name;
}

int Dog::getAge() const
{
	return this->age;
}

string Dog::getPhotograph() const
{
	return this->photograph;
}


Dog& Dog::operator=(const Dog& dog)
{
	if (this == &dog)
		return *this;

	this->breed = dog.breed;
	this->name = dog.name;
	this->age = dog.age;
	this->photograph = dog.photograph;

	return *this;

}