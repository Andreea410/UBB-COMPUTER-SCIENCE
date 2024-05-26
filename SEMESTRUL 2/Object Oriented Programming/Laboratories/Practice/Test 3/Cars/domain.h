#pragma once
#include <string>
using namespace std;
class Car
{
private:
	string name;
	string model;
	int year;
	string color;
public:
	Car();
	Car(string name, string model, int year, string color);
	string getName();
	string getModel();
	int getYear();
	string getColor();
	void setName(string name);
	void setModel(string model);
	void setYear(int year);
	void setColor(string color);
	bool operator==(const Car& c);
	string toString();
};

