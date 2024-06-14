#include "Car.h"

string Car::toString()
{
	return "Body Style: " + this->bodyStyle + "\n" + engine->toString()
		+"\nBase price: " + to_string(this->computePrice()) + "\n";
}

double Car::computePrice()
{
	double price = 800 + this->engine->getPrice();
	if (this->bodyStyle == "Convertible")
		price += 1000;
	return price;

}
