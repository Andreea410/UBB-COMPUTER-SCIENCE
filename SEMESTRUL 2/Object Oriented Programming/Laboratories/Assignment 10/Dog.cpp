#include "Dog.h"


vector<string> tokenize(const std::string& str, char delimiter) {
	std::vector<std::string> result;
	std::stringstream ss(str);
	std::string(token);
	while (getline(ss, token, delimiter))
		result.push_back(token);
	return result;
}


Dog::Dog(string breed, string name, int age, string photograph, bool isAdopted)
{
	this->breed = breed;
	this->name = name;
	this->age = age;
	this->photograph = photograph;
	this->isAdopted = isAdopted;
}

string Dog::toStr()
{
	stringstream buffer;
	buffer << "Breed: " << this->breed << endl << "Name: " << this->name << endl << "Age : " << this->age << endl << "Photograph : " << this->photograph << endl;
	return buffer.str();
}

Dog::Dog()
{
	this->breed = "";
	this->name = "";
	this->age = 0;
	this->photograph = "";
	this->isAdopted = false;
}

string Dog::getBreed() const
{
	return this->breed;
}

string Dog::getName() const
{
	return this->name;
}

int Dog::getAge() const
{
	return this->age;
}

string Dog::getPhotograph() const
{
	return this->photograph;
}

bool Dog::getIsAdopted() const
{
	return this->isAdopted;
}

void Dog::setIsAdopted(bool isAdopted)
{
	this->isAdopted = isAdopted;
}


Dog& Dog::operator=(const Dog& dog)
{
	if (this == &dog)
		return *this;

	this->breed = dog.breed;
	this->name = dog.name;
	this->age = dog.age;
	this->photograph = dog.photograph;
	this->isAdopted = dog.isAdopted;

	return *this;

}

istream& operator>>(std::istream& is, Dog& entity) {
	std::string line;
	getline(is, line);

	vector<string> tokens = tokenize(line, ',');
	if (tokens.size() != 5)
		return is;

	entity.breed = tokens[0];
	entity.name = tokens[1];
	entity.age = stoi(tokens[2]);
	entity.photograph = tokens[3];
	if (stoi(tokens[4]) == 0)
		entity.isAdopted = false;
	else
		entity.isAdopted = true;

	return is;
}

ostream& operator<<(ostream& os, const Dog& entity) {
	os << entity.breed << ","
		<< entity.name << ","
		<< entity.age << ","
		<< entity.photograph << ","
		<< (entity.isAdopted ? "1" : "0") << endl;
	return os;
}