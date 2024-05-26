#pragma once
#include <fstream>
#include <string>
#include<string.h>

using namespace std;

class Equation
{
private:
	double a, b, c;
public:
	Equation();
	Equation(double a, double b, double c);
	double getA() { return this->a; }
	double getB() { return this->b; }
	double getC() { return this->c; }
	void setA(double a) { this->a = a; }
	void setB(double b) { this->b = b; }
	void setC(double c) { this->c = c; }
	double evaluate(double x);
	double evaluate(double x, double y);
	std::string toStr() const;
	string solve() const;
};

