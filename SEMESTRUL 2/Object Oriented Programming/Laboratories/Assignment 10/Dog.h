#pragma once
#include <iostream>
#include <string>
#include <sstream>
#include <vector>
using namespace std;


class Dog
{
public:
	Dog(string breed, string name, int age, string photograph, bool isAdopted);
	Dog();

private:
	string breed;
	string name;
	int age;
	string photograph;
	bool isAdopted;

public:
	//GETTERS//

	string getBreed() const;
	string getName() const;
	int getAge() const;
	string getPhotograph() const;
	bool getIsAdopted() const;

	string toStr();
	Dog& operator = (const Dog& dog);

	void setIsAdopted(bool isAdopted);

	friend ostream& operator<<(ostream& os, const Dog& entity);
	friend istream& operator>>(std::istream& is, Dog& entity);
};

inline bool operator == (const Dog& a, const Dog& b)
{
	return (a.getBreed() == b.getBreed() && a.getAge() == b.getAge() && a.getName() == b.getName());
}
