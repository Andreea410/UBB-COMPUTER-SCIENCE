#pragma once
#include <string>
#include <string.h>

using namespace std;

class Bill
{
private:
	string name;
	string code;
	double sum;
	bool isPaid;
public:
	Bill() {};
	Bill(string name, string code, double sum, bool isPaid)
	{
		this->name = name;
		this->code = code;
		this->sum = sum;
		this->isPaid = isPaid;
	};

	string getName()
	{
		return this->name;
	};

	string getCode()
	{
		return this->code;
	};

	double getSum()
	{
		return this->sum;
	};

	bool getIsPaid() { return this->isPaid; };

	string toStr()
	{
		string result = this->getName() + " |"
			+to_string(this->getSum());
		return result;
	};

};

