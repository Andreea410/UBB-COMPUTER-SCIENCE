#pragma once
#include "Domain.h"
#include <vector>
#include <string.h>
#include <iostream>
#include <fstream>

using namespace std;
class Repository
{
private:
	vector<Equation> equations;
	string filename = "equations.txt";
public:
	Repository();
	Repository(string filename);
	vector<Equation> getEquations() { loadFromFile();
	return this->equations; }
	void updateEquation(int index,Equation e);
	void loadFromFile();
	void saveToFile();

	
};

