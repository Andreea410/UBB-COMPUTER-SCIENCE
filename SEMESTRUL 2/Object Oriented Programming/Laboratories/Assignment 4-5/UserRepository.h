#pragma once
#include "DynamicArray.h"
#include "Dog.h"

class UserRepository
{
private:
	DynamicArray<Dog> adoptedDogs;

public:
	int getSize();
	DynamicArray<Dog> getAdoptedDogs();
	int findAdoptedDog(Dog dog);
	bool addUser(Dog dog);

};
