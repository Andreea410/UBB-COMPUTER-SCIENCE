#pragma once
#include <vector>
#include "Domain.h"
#include <fstream>
#include <sstream>

using namespace std;

class Repository
{
private:
	string filename = "bills.txt";
	vector<Bill> bills;
public:
	Repository() {};
	void loadFromFile()
	{
		ifstream inputfile(this->filename);

		string line, name, code, sumStr, isPaidStr;
		while (getline(inputfile, line))
		{
			istringstream ss(line);
			getline(ss, name, ':');
			getline(ss, code, ':');
			getline(ss, sumStr, ':');
			getline(ss, isPaidStr, ':');
			bool isPaid;
			if (isPaidStr == "false")
				isPaid = false;
			else
				isPaid = true;
			this->bills.push_back(Bill(name, code,stod(sumStr),isPaid));

		}
		inputfile.close();

	};

	vector<Bill> getBills()
	{
		this->bills.clear();
		loadFromFile();
		return this->bills;
	};

	double calculateAll(string name)
	{
		this->bills.clear();
		loadFromFile();
		double totalSum;
		totalSum = 0;
		for (Bill b : this->bills)
			if (b.getIsPaid() == 0 && b.getName() == name)
				totalSum += b.getSum();
		return totalSum;
	};	 

	vector<Bill> getSortedBills()
	{
		this->bills.clear();
		loadFromFile();
		for (int i = 0; i < this->bills.size() - 1; i++)
			for (int j = i; j < this->bills.size(); j++)
				if (bills[i].getName() > bills[j].getName())
					swap(bills[i], bills[j]);
		return this->bills;

	};
};

