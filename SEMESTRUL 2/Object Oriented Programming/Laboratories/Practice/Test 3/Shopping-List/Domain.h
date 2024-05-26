#pragma once
#include <string>
#include <string.h>

using namespace std;

class Item
{
private:
	string category;
	string name;
	int quantity;
public:
	Item() {};
	Item(string category, string name, int quantity);
	string getCategory();
	string getName();
	int getQuantity();
	string toStr();
};

