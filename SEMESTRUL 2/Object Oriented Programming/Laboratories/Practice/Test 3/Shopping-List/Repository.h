#pragma once
#include "Domain.h"
#include <vector>
#include <fstream>
#include <sstream>

class Repository
{
private:
	vector<Item> items;
	string filename = "items.txt";
public:
	Repository() {};
	vector<Item> getItems() { loadFromFile(); return this->items; };
	void loadFromFile();
	void saveToFile();
	vector<Item> getItemsSorted();
};

