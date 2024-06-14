#include "UI.h"
#include <iostream>
#include <string>

using namespace std;

void UI::displayMenu()
{
	cout << "1.Add car" << endl;
	cout <<"2.Display cars" << endl;
	cout << "3.Write to file" << endl;
	cout << "0.Exit" << endl;
}

void UI::addCar()
{
	int autonomy = 0;
	string bodyStyle;
	cout<<"Body style: ";
	getline(cin, bodyStyle);
	while (bodyStyle != "Sedan" && bodyStyle != "Convertible")
	{
		cout <<"Please enter a valid body style (Sedan or Convertible): ";
		getline(cin, bodyStyle);
	}

	string engineType;
	string fuelType;
	cout << "Engine type: ";
	getline(cin, engineType);
	while (engineType != "Electric" && engineType != "Turbo")
	{
		cout << "Please enter a valid engine type (Electric or Turbo): ";
		getline(cin, engineType);
	}

	if (engineType == "Turbo")
	{
		cout << "Fuel type: ";
		getline(cin, fuelType);
		while (fuelType != "diesel" && fuelType != "gasoline")
		{
			cout << "Please enter a valid fuel type (diesel or gasoline): ";
			getline(cin, fuelType);
		}

	}
	else
	{
		cout << "Autonomy: ";
		cin >> autonomy;
		fuelType = "Electric";
	}

	this->service.addCar(bodyStyle, engineType,fuelType,autonomy);
	cout << "The price is : " << this->service.getLastAddedCar().computePrice()<<endl;

	
}

void UI::displayCars()
{
	for (Car element : this->service.getAll())
		cout << element.toString();


}

void UI::writeToFile()
{
	double price;
	cout << "Maximum price: ";
	cin >> price;
	this->service.writeToFile("cars.txt" , this->service.getCarsWithMaxPrice(price));
}

void UI::run()
{
	int option = 1;
	while (option)
	{
		displayMenu();
		cout << "Option: ";
		cin >> option;
		switch (option)
		{
			case 1:
				addCar();
				break;
			case 2:
				displayCars();
				break;
			case 3:
				writeToFile();
				break;
			case 0:
				cout <<"Now exiting..."<<endl;
				break;
		}
	}
}