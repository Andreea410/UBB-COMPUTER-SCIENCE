#include "UI.h"
#include <exception>
#include <vector>

UI::UI(Service serv)
{
	this->service = serv;
}


void UI::isNumber(const string& str)
{
	for (char const& c : str)
	{
		if (isdigit(c) == 0)
			throw 20;
	}
}

int UI::readIntegerNumber(const char* message)
{
	char s[16];
	int res;
	int flag = 0;
	int r = 0;

	while (flag == 0)
	{
		cout << message;
		cin >> s;
		r = sscanf(s, "%d", &res);
		if (r == 1)
		{
			flag = 1;
		}
		else
		{
			cout << "Invalid number!" << endl;
		}
	}
	return res;
}


int UI::login()
{
	cout << "Welcome to the ADOPT A DOG shelter!" << endl;
	cout << "How would you like to login in today?" << endl;
	cout << "1. Admin" << endl;
	cout << "2. User" << endl;
	cout << "0. Exit" << endl;
	cout << "Please choose a login option: ";
	string option;
	getchar();
	getline(cin, option);
	try
	{
		isNumber(option);
		int opt;
		opt = stoi(option);
		return opt;
	}
	catch (exception& e)
	{
		cout << "Please enter a valid number!" << endl;
		return -1;
	}

}

void UI::run()
{
	int option = 1;
	while (option != 0)
	{
		option = login();
		if (option == -1)
			continue;
		if (option == 0)
		{
			cout << "Goodbye!" << endl;
			break;
		}
		if (option == 1)
			runManagerUi();
		if (option == 2)
			runUserUI();
	}
}


void UI::displayAdminMenu()
{
	cout << "///////////////////////////////////" << endl;
	cout << "//Welcome to the Dog Shelter!    //" << endl;
	cout << "//1.Add a new dog                //" << endl;
	cout << "//2.Delete a dog                 //" << endl;
	cout << "//3.Update a dog                 //" << endl;
	cout << "//4.Display all dogs		      //" << endl;
	cout << "//0.Exit						  //" << endl;
	cout << "///////////////////////////////////" << endl;
}

void UI::addAdminUI()
{
	string name;
	fgetc(stdin); //read the newline to prevent it from going further
	cout << "Please enter the name of the dog: ";
	getline(cin, name);

	string breed;
	cout << "Please enter the breed of the dog: ";
	getline(cin, breed);

	string ageVerify;
	int age;
	cout << "Please enter the age of the dog: ";
	getline(cin, ageVerify);

	try
	{
		isNumber(ageVerify);
		age = stoi(ageVerify);
	}
	catch (int e)
	{
		cout << "Please enter a valid number!" << endl;
		return;
	}

	string photograph;
	cout << "Please enter the photograph of the dog: ";
	getline(cin, photograph);

	try
	{
		Dog d{ breed , name , age , photograph , false };
		this->service.addAdmin(d);
	}
	catch (DogExceptions& e)
	{
		for (auto s : e.getErrors())
			cout << s;
	}
	catch (RepositoryException& e)
	{
		cout << e.what() << endl;
	}
	catch (FileException& e)
	{
		cout << e.what() << endl;
	}

}

void UI::removeAdminUI()
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

	try
	{
		isNumber(ageVerify);
		age = stoi(ageVerify);
	}
	catch (int e)
	{
		cout << "Please enter a valid number!" << endl;
		return;
	}

	try {
		this->service.removeAdmin(Dog(breed, name, age, "www.", false));
	}
	catch (DogExceptions& e)
	{
		for (auto s : e.getErrors())
			cout << s;
	}
	catch (RepositoryException& e)
	{
		cout << e.what() << endl;
	}
	catch (FileException& e)
	{
		cout << e.what() << endl;
	}
}


void UI::displayAdminUI() {
	try {
		this->service.getRepo()->loadFromFile();
	}
	catch (FileException& e)
	{
		cout << e.what() << endl;

	}

	for (int i = 0; i < this->service.getRepo()->getDogs().size(); i++) {
		std::cout << i + 1 << ". " << this->service.getRepo()->getDogs()[i].toStr();
	}
}

void UI::updateAdminUI()
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

	try {
		isNumber(new_ageVerify);
		new_age = stoi(new_ageVerify);
	}
	catch (exception& e)
	{
		cout << "Please enter a valid number!" << endl;
		return;
	}

	string new_photograph;
	cout << "Please enter the updated photograph of the dog: ";
	getline(cin, new_photograph);


	try {
		this->service.updateAdmin(Dog(breed, name, age, "www.j", false), Dog(new_breed, new_name, new_age, new_photograph, false));
	}
	catch (DogExceptions& e)
	{
		for (auto s : e.getErrors())
			cout << s;
	}
	catch (RepositoryException& e)
	{
		cout << e.what() << endl;
	}
	catch (FileException& e)
	{
		cout << e.what() << endl;
	}
}


int UI::runManagerUi() {
	//this->service.getRepo().loadFromFile();
	while (1)
	{
		displayAdminMenu();
		cout << endl;
		cout << endl;
		vector<int>validOptions = { 0,1,2,3,4 };
		int command = readIntegerNumber("Please choose an option from above: ");
		while (find(validOptions.begin(), validOptions.end(), command) == validOptions.end())
		{
			cout << "Invalid command!" << endl;
			command = readIntegerNumber("Please choose an option from above: ");
		}
		if (command == 0)
		{
			cout << "Goodbye!" << endl;
			return 0;
		}
		switch (command)
		{
		case 1:
			cout << "You chose to add a new dog." << endl;
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

int UI::runUserUI()
{
	//this->service.getrepo().loadfromfile();
	int option = 1;
	while (option != 0)
	{
		displayUserMenu();
		cout << "Please choose an option: ";
		cin >> option;
		cout << endl;
		cout << endl;
		if (option == 0)
		{
			cout << "now exiting ...";
			return 0;
		}
		if (option == 1)
		{
			getchar();
			displayAllDogs();
		}
		if (option == 2)
		{
			getchar();
			displayDogsOfBreed();
		}
		if (option == 3)
			displayAdoptedDogs();
	}
	return 0;
}


void UI::displayUserMenu()
{
	cout << "Welcome to the keep calm and adopt a pet shelter.what would you like to do" << endl;
	cout << "1.See all the dogs" << endl;
	cout << "2.See all the dogs of a given breed" << endl;
	cout << "3.See the adoption list" << endl;
	cout << "0.Exit" << endl;

}

void UI::adoptDog(Dog dog)
{
	try
	{
		this->service.addUser(dog);
	}
	catch (RepositoryException& e)
	{
		cout << e.what() << endl;
	}
	catch (FileException& e)
	{
		cout << e.what() << endl;
	}
	catch (DogExceptions& e)
	{
		for (auto s : e.getErrors())
			cout << s;
	}

}

void UI::displayAllDogs()
{
	int  i = -1;
	for (Dog element : this->service.getRepo()->getDogs())
	{
		i++;
		cout << i + 1 << "." << "breed: " << element.getBreed() << endl;
		cout << "name: " << element.getName() << endl;
		cout << "age: " << element.getAge() << endl;
		cout << " photograph: " << element.getPhotograph() << endl;
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
			Dog dog = this->service.getRepo()->getDogs().at(i);
			try
			{
				adoptDog(dog);
			}
			catch (exception& e)
			{
				cout << e.what() << endl;
			}
		}

	}
}

string UI::getbreed()
{
	cout << "please enter the breed you are looking for: ";
	string breed;
	getline(cin, breed);
	return breed;

}

void UI::displayDogsOfBreed()
{
	string breed = getbreed();
	int ok = 1;
	int i = -1;
	for (Dog element : this->service.getRepo()->getDogs())
		if (element.getBreed() == breed)
		{
			i++;
			ok = 0;
			cout << i << '.' << "breed: " << element.getBreed() << endl;
			cout << "name: " << element.getName() << endl;
			cout << "age: " << element.getAge() << endl;
			cout << " photograph: " << element.getPhotograph() << endl;
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
				Dog dog = this->service.getRepo()->getDogs().at(i);
				adoptDog(dog);
			}
		}
	if (ok)
		cout << "there are no dogs with the given breed." << endl;

}

int UI::getUserOption()
{
	string option;
	//int finaloption;
	cout << "please choose an option from above: ";
	getline(cin, option);
	try
	{
		isNumber(option);
		return stoi(option);
	}
	catch (int e)
	{
		cout << "please enter a valid number!" << endl;
	}
	return -1;
}

void UI::displayOptionsAdoption()
{
	cout << "do you want to adopt this dog" << endl;
	cout << "1.yes" << endl;
	cout << "2.no" << endl;
	cout << "0.exit" << endl;

}


void UI::displayAdoptedDogs()
{
	for (Dog element : this->service.getRepo()->getDogs())
		if (element.getIsAdopted() == true)
		{
			cout << "breed: " << element.getBreed() << endl;
			cout << "name: " << element.getName() << endl;
			cout << "age: " << element.getAge() << endl;
			cout << "photograph: " << element.getPhotograph() << endl;
			cout << endl;
			cout << endl;
		}
}