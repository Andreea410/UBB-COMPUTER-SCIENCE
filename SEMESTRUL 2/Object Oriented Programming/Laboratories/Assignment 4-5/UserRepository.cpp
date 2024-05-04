#include "UserRepository.h"
#include "Dog.h"

int UserRepository::getSize()
{
	return this->adoptedDogs.getSize();
}

DynamicArray<Dog>UserRepository::getAdoptedDogs()
{
	return this->adoptedDogs;
}

int UserRepository::findAdoptedDog(Dog dog)
{
	for (int i = 0; i < this->adoptedDogs.getSize(); i++)
		if (this->adoptedDogs.getElement(i) == dog)
			return i;  
	return -1;
}

bool UserRepository::addUser(Dog dog)
{
	if (findAdoptedDog(dog) != -1)
		return false;
	this->adoptedDogs.addElement(dog);
	return true;
}
