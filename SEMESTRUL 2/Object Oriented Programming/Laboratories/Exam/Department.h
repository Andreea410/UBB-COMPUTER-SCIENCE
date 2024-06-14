#pragma once
#include <string>
#include <string.h>

using namespace std;
class Department
{
private:
	string name;
	string description;
public:
	Department() {};
	Department(string name, string d)
	{
		this->name = name;
		this->description = d;

	}

	string getName()
	{
		return this->name;
	}
	string getDescription()
	{
		return this->description;
	}
};

