#include "Domain.h"

Item::Item(string category, string name, int quantity)
{
	this->category = category;
	this->name = name;
	this->quantity = quantity;
}

string Item::getCategory()
{
	return this->category;
}

string Item::getName()
{
	return this->name;
}

int Item::getQuantity()
{
	return this->quantity;
}

string Item::toStr()
{
	string result = "";
	result += this->getCategory() + " " + this->getName() + " " + to_string(this->getQuantity());
	return result;
}