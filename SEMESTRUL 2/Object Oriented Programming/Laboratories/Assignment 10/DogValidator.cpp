#include "DogValidator.h"
#include<vector>
#include<string>
using namespace std;

DogExceptions::DogExceptions(vector<string> _errors) : errors{ _errors }
{
}

vector<string> DogExceptions::getErrors() const
{
	return this->errors;
}

void DogValidator::validate(const Dog& d)
{
	vector<string> errors;
	if (d.getBreed().size() < 3)
		errors.push_back("The breed name must be at least 3 characters long!");
	if (d.getName().size() < 3)
		errors.push_back("The name must be at least 3 characters long!");
	if (d.getAge() < 0)
		errors.push_back("The age must be a positive number!");

	size_t posWww = d.getPhotograph().find("www");
	size_t posHttp = d.getPhotograph().find("http");
	if (posWww != 0 && posHttp != 0)
		errors.push_back("The youtube source must start with one of the following strings: \"www\" or \"http\"");

	if (errors.size() > 0)
		throw DogExceptions(errors);


}

