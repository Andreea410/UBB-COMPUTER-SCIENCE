#pragma once
#include <string>
#include <string.h>

using namespace std;
class Volunteer
{
private:
	string name;
	string email;
	string interests;
	string departament;
public:
	Volunteer() {};
	Volunteer(string name, string email, string i, string d)
	{
		this->name = name;
		this->departament = d;
		this->email = email;
		this->interests = i;
	}

	Volunteer(const Volunteer& other)
	{
		this->name = other.name;
		this->email = other.email;
		this->interests = other.interests;
		this->departament = other.departament;

	}

	string getName()
	{
		return this->name;
	}

	string getEmail()
	{
		return this->email;
	}

	string getInterests()
	{
		return this->interests;
	}

	string getDepartament()
	{
		return this->departament;
	}

	string toStr()
	{
		string result;
		result+= "Name: " + this->name + " | Email: "+ this->email + "  | Interests: " + this->interests;
		return result;
	}

	void setDepartament(string d)
	{
		this->departament = d;
	}
};

