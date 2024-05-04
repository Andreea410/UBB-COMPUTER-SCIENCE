#pragma once
#include <vector>
#include "Dog.h"
#include <string>
#include "RepositoryExceptions.h"
#include <fstream>
using namespace std;


class Repository
{
protected:
	vector<Dog> dogs;
	vector < string > strings;
	string file;
public:
	Repository(const string filename)
	{
		this->file = filename;
	}
	
	virtual ~Repository() {}

	int getSize();
	virtual vector<Dog> getDogs();
	virtual int findDog(Dog dog);
	virtual void addAdmin(const Dog& dog);
	virtual void removeAdmin(Dog dog);
	virtual void updateAdmin(Dog dog, Dog newDog);

	int findAdoptedDog(Dog dog);
	virtual void addUser(Dog dog);
	virtual void saveToFile();
	virtual vector<Dog> loadFromFile();
	void setDoglist(vector<Dog> newList);
	void customSplit(string str, char separator);
	Dog findByNameandPhotogtaph(const string& name, const string& photograph);

};