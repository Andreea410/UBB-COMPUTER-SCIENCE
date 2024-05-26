#include "Domain.h"
#include <vector>

using namespace std;

Equation::Equation()
{
	this->a = 0;
	this->b = 0;
	this->c = 0;
}

Equation::Equation(double a, double b, double c)
{
	this->a = a;
	this->b = b;
	this->c = c;
}

double Equation::evaluate(double x)
{
	return this->a * x * x + this->b * x + this->c;
}

double Equation::evaluate(double x, double y)
{
	return this->a * x * x + this->b * y + this->c;
}

string Equation::toStr() const
{
	string result;
	if (a != 0)
		result += to_string(a) + "x^2";
	if (b != 0)
		result += (b > 0 ? "+" : "") + to_string(b) + "x";
	if (c != 0)
		result += (c > 0 ? "+" : "") + to_string(c);
	return result;
}

string Equation::solve() const
{
	double discriminant = b * b - 4 * a * c;
	if (discriminant == 0)
		return "x=" + to_string(-b / (2 * a));
	else if (discriminant > 0)
		return "x1=" + to_string((-b + sqrt(discriminant)) / 2 * a) + "x2=" + to_string((-b - sqrt(discriminant)) / 2 * a);
	else
		return "x1=" + to_string(-b / 2 * a) + to_string(-sqrt(-discriminant) / 2 * a) + "i" + " x2=" + to_string(-b / 2 * a) + "+" + to_string(sqrt(-discriminant) / 2 * a) + "i";
}


