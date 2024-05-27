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
	Item(string category, string name, int quantity)
	{
		this->category = category;
		this->name = name;
		this->quantity = quantity;
	};
	string getCategory()
	{
		return category;
	};
	string getName() {
		return name;
	};
	int getQuantity() {
		return quantity;
	};

	string toStr()
	{
		string result = category + " | " + name + " | " + to_string(quantity);
		return result;
	};

};