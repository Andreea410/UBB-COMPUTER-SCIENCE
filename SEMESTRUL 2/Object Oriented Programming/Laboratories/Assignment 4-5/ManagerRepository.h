#pragma once
#include "Dog.h"
#include "DynamicArray.h"

class ManagerRepository
{
private:
	DynamicArray<Dog> dogs;
	public:
		int getSize();
		DynamicArray<Dog> getDogs();
		int findDog(Dog dog);
		bool addAdmin(Dog dog);
		bool removeAdmin(Dog dog);
		bool updateAdmin(Dog dog, Dog newDog);

};