#include <iostream>
#include <cstring>

#include "UserUi.h"

using namespace std;

UserUI::~UserUI(){}

bool UserUI::isNumber(const string &str)
{
	for (char const& c : str)
	{
		if (isdigit(c) == 0)
			return false;
	}
	return true;
}
void UserUI::displayMenu()
{
	cout << "Welcome to the KEEP CALM AND ADOPT A PET shelter.What would you like to do"<< endl;
	cout << "1.See all the dogs"<<endl;
	cout << "2.See all the dogs of a given breed" << endl;
	cout << "3.See the adoption list" << endl;
	cout << "0.Exit" << endl;

}

int UserUI::getUserOption()
{
	string option;
	int finalOption;
	cout << "Please choose an option from above: ";
	getline(cin , option);
	while (!isNumber(option))
	{
		cout << "Invalid option.Please choose another option: ";
		getline(cin, option);
	}
	finalOption = stoi(option);
	return finalOption;

}

void UserUI::displayOptionsAdoption()
{
	cout << "Do you want to adopt this dog" << endl;
	cout << "1.Yes" << endl;
	cout << "2.No" << endl;
	cout << "0.Exit" << endl;

}

void UserUI::adoptDog(Dog dog)
{
	bool result = this->service.addUser(dog);
	if (result == false)
		cout << "The dog has been already adopted" << endl;
	else
		cout << "Dog adopted succesfully" << endl;
}

void UserUI::displayAllDogs()
{
	for (int i = 0; i < this->service.getAdminRepo().getSize(); i++)
	{
		cout << i + 1 << "." << "Breed: " << this->service.getAdminRepo().getDogs().getElement(i).getBreed() << endl;
		cout << "Name: " << this->service.getAdminRepo().getDogs().getElement(i).getName() << endl;
		cout << "Age: " << this->service.getAdminRepo().getDogs().getElement(i).getAge() << endl;
		cout << " Photograph: " << this->service.getAdminRepo().getDogs().getElement(i).getPhotograph() << endl;
		cout << endl;
		cout << endl;
		displayOptionsAdoption();
		int option = getUserOption();
		cout << endl;
		cout << endl;

		if (option == 0)
			break;
		if (option == 1)
		{
			Dog dog = this->service.getAdminRepo().getDogs().getElement(i);
			adoptDog(dog);
		}

	}
}

string UserUI::getBreed()
{
	cout << "Please enter the breed you are looking for: ";
	string breed;
	getline(cin, breed);
	return breed;

}

void UserUI::displayDogsOfBreed()
{
	string breed = getBreed();
	int ok = 1;
	for (int i = 0; i < this->service.getAdminRepo().getDogs().getSize(); i++)
		if (this->service.getAdminRepo().getDogs().getElement(i).getBreed()== breed)
		{
			ok = 0;
			cout << i + 1 << "." << "Breed: " << this->service.getAdminRepo().getDogs().getElement(i).getBreed() << endl;
			cout << "Name: " << this->service.getAdminRepo().getDogs().getElement(i).getName() << endl;
			cout << "Age: " << this->service.getAdminRepo().getDogs().getElement(i).getAge() << endl;
			cout << " Photograph: " << this->service.getAdminRepo().getDogs().getElement(i).getPhotograph() << endl;
			cout << endl;
			cout << endl;
			displayOptionsAdoption();
			int option = getUserOption();
			cout << endl;
			cout << endl;
			if (option == 0)
				break;
			if (option == 1)
			{
				Dog dog = this->service.getAdminRepo().getDogs().getElement(i);
				adoptDog(dog);
			}
		}
	if (ok)
		cout << "There are no dogs with the given breed." << endl;

}

void UserUI::displayAdoptedDogs()
{
	for (int i = 0; i < this->service.getUserRepo().getSize(); i++) {
		cout << "Breed: " << this->service.getUserRepo().getAdoptedDogs().getElement(i).getBreed() << endl;
		cout << "Name: " << this->service.getUserRepo().getAdoptedDogs().getElement(i).getName() << endl;
		cout << "Age: " << this->service.getUserRepo().getAdoptedDogs().getElement(i).getAge() << endl;
		cout<< "Photograph: " << this->service.getUserRepo().getAdoptedDogs().getElement(i).getPhotograph() << endl;
		cout << endl;
		cout << endl;
	}
}

void UserUI::runUserUI()
{
	this->service.generate();
	getchar();
	while (1)
	{
		displayMenu();
		int option = getUserOption();
		cout << endl;
		cout << endl;
		if (option == 0)
		{
			cout << "Goodbye!"<<endl;
			break;
		}
		if (option == 1)
				displayAllDogs();
		if (option == 2)
			displayDogsOfBreed();
		if (option == 3)
			displayAdoptedDogs();
	}
}
