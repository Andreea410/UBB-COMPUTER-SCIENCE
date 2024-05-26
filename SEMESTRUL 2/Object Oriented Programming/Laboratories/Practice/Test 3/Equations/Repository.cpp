#include "Repository.h"
#include <string>
#include <fstream>
#include <string.h>
#include <iostream>
#include <vector>
#include <stdexcept>
#include <sstream>

using namespace std;

Repository::Repository(string filename)
{
	this->filename = filename;
	loadFromFile();
}

Repository::Repository()
{}

void Repository::loadFromFile()
{
	this->equations.clear();
	ifstream inputfile(this->filename);
	if (!inputfile)
	{
		throw exception("The file couln t be opened");
		return;
	}

	string line ,astr,bstr,cstr;
	while (getline(inputfile, line))
	{
		istringstream ss(line);
		double a, b, c;
		getline(ss, astr, ',');
		getline(ss, bstr, ',');
		getline(ss, cstr, ',');

		this->equations.push_back(Equation(stod(astr), stod(bstr), stod(cstr)));
	}
	inputfile.close();

}

void Repository::updateEquation(int index, Equation e)
{
	loadFromFile();
	equations[index] = e;
	saveToFile();
}

void Repository::saveToFile()
{
	ofstream outputFile(this->filename);
	if (!outputFile.is_open())
		return;

	for (Equation& d : this->equations)
	{
		outputFile << d.getA() << ","
			<< d.getB() << ","
			<< d.getC() << "\n";

	}
	outputFile.close();
}

