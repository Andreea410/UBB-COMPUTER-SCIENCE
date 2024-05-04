#include "UserRepository.h"
#include "Dog.h"
#include <vector>

using namespace std;

UserRepository::UserRepository(vector<Dog> dogs)
{
	this->adoptedDogs = dogs;
}

int UserRepository::getSize()
{
	return this->adoptedDogs.size();
}

vector<Dog> UserRepository::getAdoptedDogs()
{
	return this->adoptedDogs;
}

int UserRepository::findAdoptedDog(Dog dog)
{
	auto i = find(adoptedDogs.begin(), adoptedDogs.end(), dog);
	if (i != adoptedDogs.end() && adoptedDogs)
		return i-adoptedDogs.begin();
	return -1;
}

bool UserRepository::addUser(Dog dog)
{
	if (findAdoptedDog(dog) != -1)
		return false;
	this->adoptedDogs.push_back(dog);
	return true;
}