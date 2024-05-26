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
	this->dogs.erase(dogs.begin() + position);
	saveToFile();
}

void Repository::updateAdmin(Dog dog, Dog newDog)
{
	this->dogs = loadFromFile();
	int position = findDog(dog);
	if (position == -1)
		throw InexistentDogException();

	dogs[position] = newDog;
	saveToFile();

}

int Repository::findAdoptedDog(Dog dog)
{
	auto i = find(dogs.begin(), dogs.end(), dog);
	if (i != dogs.end())
		if (dogs[i - dogs.begin()].getIsAdopted() == false)
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
	ifstream inputFile(file);
	if (!inputFile) {
		throw FileException("The CSV file could not be opened.\n");
	}

	vector<Dog> newList;
	string line;
	while (getline(inputFile, line)) {
		stringstream ss(line);
		string name, breed, photograph;
		int age;
		bool isAdopted;

		getline(ss, breed, ',');
		getline(ss, name, ',');
		ss >> age;
		ss.ignore();
		getline(ss, photograph, ',');
		ss >> isAdopted;

		Dog dog(breed, name, age, photograph, isAdopted);
		newList.push_back(dog);
	}

	inputFile.close();
	return newList;
}

Dog Repository::findByNameandPhotogtaph(const string& name, const string& photograph)
{
	for (auto d : this->dogs)
		if (d.getName() == name && d.getPhotograph() == photograph)
			return d;
	throw InexistentDogException();
}

void Repository::saveToFile()
{
	ofstream outputFile(file);
	if (!outputFile.is_open())
		throw FileException("The CSV file could not be opened.\n");

	for (const auto& d : this->dogs)
	{
		outputFile << d.getBreed() << ','
			<< d.getName() << ','
			<< d.getAge() << ','
			<< d.getPhotograph() << ','
			<< d.getIsAdopted() << '\n';
	}
	outputFile.close();
}

void Repository::open()
{
	vector<Dog> dogs = loadFromFile();
	ofstream outputFile("dogs1.csv");
	if (!outputFile.is_open())
		throw FileException("The CSV file could not be opened.\n");
	for (const auto& d : this->dogs)
	{
		outputFile << d.getBreed() << ','
			<< d.getName() << ','
			<< d.getAge() << ','
			<< d.getPhotograph() << ','
			<< d.getIsAdopted() << '\n';
	}
	outputFile.close();
	system(("start " + this->file).c_str());
}

vector<Dog> Repository::getAdoptedDogs()
{
	vector<Dog> dogs = loadFromFile();
	vector<Dog> adoptedDogs;
	for (auto d : dogs)
		if (d.getIsAdopted())
			adoptedDogs.push_back(d);
	return adoptedDogs;
}