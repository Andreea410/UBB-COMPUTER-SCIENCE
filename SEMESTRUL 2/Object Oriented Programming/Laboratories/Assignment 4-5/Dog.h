#pragma once
#include <string>
using namespace std;

class Dog
{
public:
	Dog(string breed, string name, int age, string photograph);
	Dog();

private:
	string breed;
	string name;
	int age;
	string photograph;

public:
	//GETTERS//

	string getBreed() const;
	string getName() const;
	int getAge() const;
	string getPhotograph() const;

	string toStr();
	Dog& operator = (const Dog & dog);

};

inline bool operator == (const Dog & a, const Dog & b)
{
	return (a.getBreed() == b.getBreed() && a.getAge() == b.getAge() && a.getName() == b.getName());
}