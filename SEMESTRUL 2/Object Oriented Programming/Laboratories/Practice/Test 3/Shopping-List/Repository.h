#include "Domain.h"
#include <string>
#include <string.h>
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
	void loadFromFile()
	{
		ifstream input(filename);
		items.clear();
		string line, category, name, quantity;
		while (getline(input, line))
		{
			istringstream ss(line);
			getline(ss, category, ',');
			getline(ss, name, ',');
			getline(ss, quantity, ',');
			items.push_back(Item(category, name, stoi(quantity)));

		}
		input.close();
	};

	vector<Item> getItems()
	{
		this->loadFromFile();
		for (int i = 0; i < items.size() - 1; i++)
			for (int j = i; j < items.size(); j++)
				if (items[i].getCategory() > items[j].getCategory())
					swap(items[i], items[j]);
				else if(items[i].getCategory() == items[j].getCategory())
					if(items[i].getName() > items[j].getName())
						swap(items[i], items[j]);
		return this->items;
	};

	vector<Item> getItemsSorted()
	{
		this->loadFromFile();
		for (int i = 0; i < items.size() - 1; i++)
			for (int j = i; j < items.size(); j++)
				if (items[i].getQuantity() > items[j].getQuantity())
					swap(items[i], items[j]);
				
		return this->items;
	};
};