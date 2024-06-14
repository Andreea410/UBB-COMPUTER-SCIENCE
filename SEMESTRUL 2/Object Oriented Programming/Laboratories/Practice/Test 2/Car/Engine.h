#pragma once
#include<string>

using namespace std;
class Engine
{
protected:
	string fuelType;
	double basePrice;
public:
	Engine(string fuelType = "") : fuelType(fuelType), basePrice(3000) {};
	virtual ~Engine() {};
	virtual double getPrice() { return 0; };
	virtual string toString();
};

class ElectricEngine : public Engine
{
private:
	int autonomy;
public:
	ElectricEngine(string FuelType = "", int autonomy = 0) : Engine{ FuelType }, autonomy{ autonomy } {};
	double getPrice();
	string toString();
};

class TurboEngine : public Engine
{
public:
	TurboEngine(string fuelType = "") : Engine{fuelType} {};
	double getPrice();
	string toString();
};

