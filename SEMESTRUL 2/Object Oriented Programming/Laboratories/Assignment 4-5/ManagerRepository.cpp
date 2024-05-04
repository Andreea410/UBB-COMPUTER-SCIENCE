#include "ManagerRepository.h"
#include "Dog.h"

int ManagerRepository::getSize()
{
	return this->dogs.getSize();
}

DynamicArray<Dog>ManagerRepository::getDogs()
{
	return this->dogs;
}


int ManagerRepository::findDog(Dog dog)
{
	for (int i = 0; i < this->dogs.getSize(); i++)
	{
		if (this->dogs.getElement(i) == dog)
			return i;
	}
	return -1;
}

bool ManagerRepository::addAdmin(Dog dog)
{
	if (findDog(dog) != -1)
		return false;
	this->dogs.addElement(dog);
	return true;

}

bool ManagerRepository :: removeAdmin(Dog dog)
{
	int position = findDog(dog);
	if (position == -1)
		return false;
	this->dogs.removeElement(position);
	return true;
}

bool ManagerRepository::updateAdmin(Dog dog , Dog newDog)
{
	int position = findDog(dog);
	if (position == -1)
		return false;

	this->dogs.updateElement(position, newDog);
	return true;

}
