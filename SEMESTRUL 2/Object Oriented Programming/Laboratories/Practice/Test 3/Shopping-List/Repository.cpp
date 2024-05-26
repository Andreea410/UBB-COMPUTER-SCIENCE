#include "Repository.h"


void Repository:: loadFromFile()
{
	this->items.clear();
	ifstream inputfile(this->filename);
	if (!inputfile.is_open())
		return;

	string line, category, name , quantitystr;
	int quantity;
	while (getline(inputfile, line))
	{
		istringstream ss(line);
		getline(ss, category, ',');
		getline(ss, name, ',');
		getline(ss, quantitystr, ',');
		quantity = stoi(quantitystr);
		this->items.push_back(Item(category, name, quantity));

	}
	inputfile.close();
}

vector<Item> Repository::getItemsSorted()
{
	loadFromFile();
	for (int i = 0; i < this->items.size() - 1; i++)
		for (int j = i; j < this->items.size(); j++)
			if (items[i].getCategory() > items[j].getCategory())
				swap(items[i], items[j]);
			else if(items[i].getCategory() == items[j].getCategory())
				if(items[i].getName() > items[j].getName())
					swap(items[i], items[j]);

	return this->items;
}