#pragma once
#include "Dog.h"
#include <vector> 
using namespace std;

class UserRepository
{
private:
	vector<Dog> adoptedDogs;
public:
	UserRepository(vector<Dog> dogs);
	int getSize();
	vector<Dog> getAdoptedDogs();
	int findAdoptedDog(Dog dog);
	bool addUser(Dog dog);
};