#include <iostream>
#include <stdbool.h>
#include "ManagerUI.h"

using namespace std;

bool managerUI::isNumber(const string& str)
{
	for(char const &c:str)
	{
		if (isdigit(c) == 0)
			return false;
	}
	return true;
}
managerUI::~managerUI()
{
}
void managerUI::displayMenu()
{
	cout<< "Welcome to the Dog Shelter!You are the manager.What would you like to do?" << endl;
	cout<<"1.Add a new dog" << endl;
	cout<<"2.Delete a dog"<<endl;
	cout<<"3.Update a dog"<<endl;
	cout << "4.Display all dogs" << endl;
	cout<<"0.Exit"<<endl;

}

bool managerUI::validCommand(int command)
{
	if (command == 1 || command == 2 || command == 3 || command == 0 || command == 4)
	{
		return true;
	}
	else
	{
		return false;
	}
}

void managerUI::readString(const char* message , int maxStrSize , char str[] )
{
	cout << message;
	cin.getline(str, maxStrSize); //the newline is also read
	size_t size = strlen(str) - 1;
	if (str[size] == '\n')
		str[size] = '\0';

}
int managerUI::readIntegerNumber(const char* message)
{
	char s[16];
	int res;
	int flag = 0;
	int r = 0;

	while(flag == 0)
	{
		cout<< message;
		cin>> s;
		r = sscanf(s, "%d", &res);
		if (r == 1)
		{
			flag = 1;
		}
		else
		{
			cout<< "Invalid number!" << endl;
		}
	}
	return res;
}

void managerUI::addAdminUI()
{
	string name;
	fgetc(stdin); //read the newline to prevent it from going further
	cout<< "Please enter the name of the dog: ";
	getline(cin , name);

	string breed;
	cout<< "Please enter the breed of the dog: ";
	getline(cin , breed);

	string ageVerify;
	int age;
	cout<< "Please enter the age of the dog: ";
	getline(cin , ageVerify);
	
	while (isNumber(ageVerify) == false)
	{
		cout<< "Invalid age!" << endl;
		cout<< "Please enter the age of the dog: ";
		getline(cin , ageVerify);
	}

	age = stoi(ageVerify);

	string photograph;
	cout<< "Please enter the photograph of the dog: ";
	getline(cin , photograph);
	
	bool result = this->service.addAdmin(Dog(breed , name , age , photograph));

	if (result)
		cout << "Dog added succesfully!" << endl;
	else
		cout << "Dog already exists" << endl;
}

void managerUI::removeAdminUI()
{
	string breed;
	fgetc(stdin); //read the newline to prevent it from going further
	cout << "Please enter the breed of the dog you want to remove: ";
	getline(cin, breed);

	string name;
	cout << "Please enter the name of the dog you want to remove: ";
	getline(cin, name);

	string ageVerify;
	int age;
	cout << "Please enter the age of the dog you want to remove: ";
	getline(cin, ageVerify);

	while (isNumber(ageVerify) == false)
	{
		cout << "Invalid age!" << endl;
		cout << "Please enter the age of the dog you want to remove: ";
		getline(cin, ageVerify);
	}

	age = stoi(ageVerify);

	bool result = this->service.removeAdmin(Dog(breed, name, age, "a"));  

	if (result)
		cout << "Dog removed succesfully!" << endl;
	else
		cout << "Dog doesn't exist." << endl;
}

void managerUI::displayAdminUI()
{
	for (int i = 0; i < this->service.getAdminRepo().getSize(); i++)
	{
		cout << i + 1 << "." << "Breed: " << this->service.getAdminRepo().getDogs().getElement(i).getBreed() << endl;
		cout << "Name: " << this->service.getAdminRepo().getDogs().getElement(i).getName() << endl;
		cout << "Age: " << this->service.getAdminRepo().getDogs().getElement(i).getAge() << endl;
		cout << " Photograph: " << this->service.getAdminRepo().getDogs().getElement(i).getPhotograph() << endl;
		cout << endl;
		cout << endl;
	}
}

void managerUI::updateAdminUI()
{
	string breed;
	fgetc(stdin); //read the newline to prevent it from going further
	cout << "Please enter the breed of the dog you want to update: ";
	getline(cin, breed);

	string name;
	cout << "Please neter the name of the dog you want to update: ";
	getline(cin, name);

	string ageVerify;
	int age;
	cout << "Please enter the age of the dog you want to update: ";
	getline(cin, ageVerify);

	age = stoi(ageVerify);

	string new_breed;
	cout << "Please enter the updated breed of the dog: ";
	getline(cin, new_breed);

	string new_name;
	cout << "Please enter the updated name of the dog: ";
	getline(cin, new_name);

	string new_ageVerify;
	int new_age;
	cout << "Please enter the updated age of the dog: ";
	getline(cin, new_ageVerify);

	while (isNumber(new_ageVerify) == false)
	{
		cout << "Invalid age!" << endl;
		cout << "Please enter the updated age of the dog: ";
		getline(cin, new_ageVerify);
	}

	new_age = stoi(new_ageVerify);

	string new_photograph;
	cout << "Please enter the updated photograph of the dog: ";
	getline(cin, new_photograph);

	bool result = this->service.updateAdmin(Dog(breed, name, age, "a") , Dog(new_breed , new_name , new_age , new_photograph));

	if (result)
		cout << "Dog updated succesfully!" << endl;
	else
		cout << "Dog doesn't exist." << endl;
}

int managerUI::runManagerUi() {

	this->service.generate();
	while (1)
	{
		displayMenu();
		cout << endl;
		cout << endl;
		int command = readIntegerNumber("Please choose an option from above: ");
		while (validCommand(command) == false)
		{
			cout << "Invalid command!" << endl;
			command = readIntegerNumber("Please choose an option from above: ");
		}
		if (command == 0)
		{
			cout<< "Goodbye!" << endl;
			return 0;
		}
		switch(command)
		{
		case 1:
			cout<< "You chose to add a new dog." << endl;
			addAdminUI();
			break;
		case 2:
			cout << "You chose to remove a dog" << endl;
			removeAdminUI();
			break;
		case 3:
			cout << "You chose to update a dog" << endl;
			updateAdminUI();
			break;
		case 4:
			displayAdminUI();
			break;
		}
	}
}