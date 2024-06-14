#include "Engine.h"

string Engine::toString()
{
	return "";
}

double ElectricEngine::getPrice()
{
	return this->basePrice + double(this->autonomy) * 0.01;
}

string ElectricEngine::toString()
{
	return "Type: Electric \n Fuel Type: Electric\n Autonomy: " + 
		to_string(this->autonomy) + ("\nPrice: ") + to_string(this->getPrice());
}

double TurboEngine::getPrice()
{
	if (this->fuelType == "diesel")
		return this->basePrice + 1.5;
	return this->basePrice+1;
}

string TurboEngine::toString()
{
	return "Type: Turbo\n Fuel Type: "+this->fuelType+ "\nPrice: " + to_string(this->getPrice());
}