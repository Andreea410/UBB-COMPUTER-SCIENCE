#pragma once
#include <string>
#include <vector>
#include "Dog.h"

using namespace std;

class DogExceptions
{
private:
	vector<string> errors;
public:
	DogExceptions(vector<string> errors);
	vector<string>  getErrors() const;
};

class DogValidator
{
public:
	DogValidator() {};
	static void validate(const Dog& dog);
};

