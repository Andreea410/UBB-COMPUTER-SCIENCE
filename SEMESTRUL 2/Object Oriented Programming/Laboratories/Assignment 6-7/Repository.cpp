#include "Repository.h"
#include<fstream>
#include <vector>
#include <stdexcept>
#include <iostream>


int Repository::getSize()
{
	return dogs.size();
}

vector<Dog> Repository::getDogs()
{
	this->dogs = loadFromFile();
	return this->dogs;
}

void Repository::setDoglist(vector<Dog> newList)
{
	this->dogs = newList;
}

int Repository::findDog(Dog dog)
{
	auto i = find(dogs.begin(), dogs.end(), dog);
	if (i != dogs.end())
		return i - dogs.begin();

	return -1;
}

void Repository::addAdmin(const Dog& dog)
{
	this->dogs = loadFromFile();
	Dog d1{};
	try
	{
		d1 = this->findByNameandPhotogtaph(dog.getName(), dog.getPhotograph());
		throw DuplicateDogException();
	}
	catch (InexistentDogException&) {}
	this->dogs.push_back(dog);
	saveToFile();
}

void Repository::removeAdmin(Dog dog)
{
	this->dogs = loadFromFile();
	int position = findDog(dog);
	if (position == -1)
		throw InexistentDogException();
	this->dogs.erase(dogs.begin()+position);
	saveToFile();
}

void Repository::updateAdmin(Dog dog, Dog newDog)
{
	this->dogs = loadFromFile();
	int position = findDog(dog);
	if (position == -1)
		throw InexistentDogException();

	dogs[position] =  newDog;
	saveToFile();

}

int Repository::findAdoptedDog(Dog dog)
{
	auto i = find(dogs.begin(), dogs.end(), dog);
	if (i != dogs.end())
		if(dogs[i-dogs.begin()].getIsAdopted() == false)
			return i - dogs.begin();

	return -1;
}

void Repository::addUser(Dog dog)
{
	this->dogs = loadFromFile();
	int position = findAdoptedDog(dog);
	if (position == -1)
		throw DuplicateDogException();

	dogs[position].setIsAdopted("true");
	saveToFile();
}

vector<Dog> Repository::loadFromFile() 
{
	ifstream inputFile(file); // Open the file for reading
	if (!inputFile) {
		throw FileException("The file could not be opened.\n");
	}

	vector<Dog> newList;
	Dog dog;
	while (inputFile >> dog)  // Read from the file until the end
		newList.push_back(dog);

	inputFile.close(); // Close the file
	return newList;
}

Dog Repository::findByNameandPhotogtaph(const string& name, const string& photograph)
{
	for(auto d: this->dogs)
		if (d.getName() == name && d.getPhotograph() == photograph)
			return d;
	throw InexistentDogException();
}

void Repository::saveToFile()
{
	ofstream outputFile(file);
	if (!outputFile.is_open())
		throw FileException("The file could not be opened.\n");

	for (auto d : this->dogs)
	{
		outputFile << d;
	}
	outputFile.close();
}