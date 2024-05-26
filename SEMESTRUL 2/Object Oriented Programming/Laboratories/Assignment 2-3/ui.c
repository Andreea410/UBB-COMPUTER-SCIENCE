#define _CRT_SECURE_NO_WARNINGS
#include "UI.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

UI* createUI(Controller* ctrl)
{
	UI* ui = (UI*)malloc(sizeof(UI));
	ui->ctrl = ctrl;

	return ui;
}


void destroyUI(UI* ui)
{
	// first destroy the controller
	destroyController(ui->ctrl);
	// free the UI memory
	free(ui);
}


/*
Prints the available menu for the problem
Input: -
Output: the menu is printed at the console
*/
void printMenu()
{
	printf("Welcome to the Happy holiday travel agency!\n");
	printf(" 1 - Add an offer.\n");
	printf(" 2 - Remove an offer.\n");
	printf(" 3 - Update an offer.\n");
	printf(" 4 - List all offers.\n");
	printf(" 5 - List offers with a given string(sorted by price).\n");
	printf(" 6 - List offers with a given type(starting from a given date).\n");
	printf(" 7 - List offers with a given type(price less than a given value, sorted ascending by price).\n");
	printf(" 8 - Undo.\n");
	printf(" 9 - Redo.\n");
	printf(" 0 - Exit.\n");
}

/*
Verifies if the given command is valid (is either 1, 2 or 0)
Input: command - integer
Output: 1 - if the command is valid
0 - otherwise
*/
int validCommand(int command)
{
	if (command >= 0 && command <= 10)
		return 1;
	return 0;
}


/*
Reads an integer number from the keyboard. Asks for number while read errors encoutered.
Input: the message to be displayed when asking the user for input.
Returns the number.
*/
int readIntegerNumber(const char* message)
{
	char s[16];
	int res = 0;
	int flag = 0;
	int r = 0;

	while (flag == 0)
	{
		printf(message);
		scanf("%s", s);

		r = sscanf(s, "%d", &res);	// reads data from s and stores them as integer, if possible; returns 1 if successful
		flag = (r == 1);
		if (flag == 0)
			printf("Error reading number!\n");
	}
	return res;
}

bool VerifType(char* type)
{
	if (strcmp(type, "citybreak") == 0 || strcmp(type, "seaside") == 0 || strcmp(type, "mountain") == 0)
		return true;
	return false;
}

/*
Reads the type, the destination, the date and the price in order to add a new offer to the repository.
Input: the message to be displayed when asking the user for input.
Returns the data for an offer(to the Controller).
*/
int addOfferUI(UI* ui)
{
	// read the offer's data
	char destination[50], type[50];
	Date departureDate;
	double price = 0;
	departureDate.day = 0;

	printf("Please input the type: ");
	scanf("%49s", type);
	while (VerifType(type) == false)
	{
		printf("Please input a valid type(citybreak, seaside, mountain): ");
		scanf("%49s", type);
	}
	printf("Please input the destination: ");
	scanf("%49s", destination);
	printf("Please input the departure date(day): ");
	scanf("%d", &departureDate.day);
	printf("Please input the departure date(month): ");
	scanf("%49s", departureDate.month);
	printf("Please input the price: ");
	scanf("%lf", &price);

	return addOfferCtrl(ui->ctrl, type, destination, departureDate.day, departureDate.month, price);
}

/*
Reads the destination and the date in order to remove an offer.
Input: the message to be displayed when asking the user for input.
Returns the data for an offer to be removed(to the Controller).
*/
int removeOfferUI(UI* ui)
{
	// read the offer's data
	char destination[50];
	Date departureDate;
	departureDate.day = 0;

	printf("Please input the destination: ");
	scanf("%49s", destination);
	printf("Please input the departure date(day): ");
	scanf("%d", &departureDate.day);
	printf("Please input the departure date(month): ");
	scanf("%49s", departureDate.month);

	return removeOfferCtrl(ui->ctrl, destination, departureDate.day, departureDate.month);
}

/*
Reads the type, the destination, the date and the price in order to update an offer to the repository.
Input: the message to be displayed when asking the user for input.
Returns the data for an offer to be updated(to the Controller).
*/
int updateOfferUI(UI* ui)
{
	// read the offer's data
	char destination[50], type[50];
	Date departureDate;
	double price = 0;
	departureDate.day = 0;


	printf("Please input the destination: ");
	scanf("%49s", destination);
	printf("Please input the departure date(day): ");
	scanf("%d", &departureDate.day);
	printf("Please input the departure date(month): ");
	scanf("%49s", departureDate.month);
	printf("Please input the new type: ");
	scanf("%49s", type);
	printf("Please input the new price: ");
	scanf("%lf", &price);

	return updateOfferCtrl(ui->ctrl, type, destination, departureDate.day, departureDate.month, price);
}

//This function lists all the offers
void listAllOffers(UI* ui)
{
	OffersRepo* repo = getRepo(ui->ctrl);
	int length = getLength(repo);

	if (length == 0)
	{
		char* str = "There are no stored offers.";
		printf("%s \n", str);
	}

	for (int i = 0; i < getLength(repo); i++)
	{
		char str[200];
		toString(getOfferOnPos(repo, i), str);
		printf("%s\n", str);
	}
	//destroyRepo(repo);
}

//This function lists all the offers for a given destination
void listOffersByDestination(UI* ui)
{
	char destination[50];
	printf("Please input the destination; input 'null' for no type: ");
	scanf("%49s", destination);

	OffersRepo* res = filterByDestination(ui->ctrl, destination);
	int length = getLength(res);
	if (length == 0)
	{
		printf("There are no offers with the given destination.");
	}
	else
	{
		for (int i = 0; i < length; i++)
		{
			char str[200];
			toString(getOfferOnPos(res, i), str);
			printf("%s\n", str);
		}
	}
	destroyRepo(res);
}


//This function lists all the offers for a give
void listOffersByType(UI* ui)
{
	char type[50] , string[100];
	getchar();
	printf("Please input the string: ");
	fgets(type, sizeof(type), stdin);
	OffersRepo* res = filterByType(ui->ctrl, type);
	int length = getLength(res);
	if (length == 0)
	{
		printf("There are no offers with the given type.");
	}
	else
	{
		for (int i = 0; i < length; i++)
		{
			char str[200];
			toString(getOfferOnPos(res, i), str);
			printf("%s\n", str);
		}
	}
	destroyRepo(res);
}

void listOffersByType2(UI* ui)
{
	char type[50], string[100];
	getchar();
	printf("Please input the string: ");
	fgets(type, sizeof(type), stdin);
	OffersRepo* res = filterByType2(ui->ctrl, type);
	int length = getLength(res);
	if (length == 0)
	{
		printf("There are no offers with the given string.");
	}
	else
	{
		for (int i = 0; i < length; i++)
		{
			char str[200];
			toString(getOfferOnPos(res, i), str);
			printf("%s\n", str);
		}
	}
	destroyRepo(res);
}

void filterByTypeLessThanAGivenPriceUi(UI* ui)
{
	char type[50];
	double price;
	getchar();
	printf("Please input the type: ");
	fgets(type, sizeof(type), stdin);
	printf("Please input the price: ");
	scanf("%lf", &price);
	OffersRepo* res = filterByTypeLessThanAGivenPrice(ui->ctrl, type, price);
	int length = getLength(res);
	if (length == 0)
	{
		printf("There are no offers with the given type.");
	}
	else
	{
		for (int i = 0; i < length; i++)
		{
			char str[200];
			toString(getOfferOnPos(res, i), str);
			printf("%s\n", str);
		}
	}
	destroyRepo(res);
}


void listOffersByTypeForDate(UI* ui)
{
	char type[50], month[20];
	int day;
	printf("Please input the type: ");
	scanf("%49s", type);
	printf("Day: ");
	scanf("%d", &day);
	printf("Month: ");
	scanf("%49s", month);

	OffersRepo* res = sortByTypeFromAGivenDate(ui->ctrl, type, day, month);
	int length = getLength(res);
	if (length == 0)
	{
		printf("There are no offers with the given type(From this date).");
	}
	else
	{
		for (int i = 0; i < length; i++)
		{
			char str[200];
			toString(getOfferOnPos(res, i), str);
			printf("%s\n", str);
		}

	}
	destroyRepo(res);
}

void listOffersByTypeForDate2(UI* ui)
{
	char type[50], month[20];
	int day;
	printf("Please input the type: ");
	scanf("%49s", type);
	printf("Day: ");
	scanf("%d", &day);
	printf("Month: ");
	scanf("%49s", month);

	OffersRepo* res = sortByTypeFromAGivenDate2(ui->ctrl, type, day, month);
	int length = getLength(res);
	if (length == 0)
	{
		printf("There are no offers with the given type(From this date).");
	}
	else
	{
		for (int i = 0; i < length; i++)
		{
			char str[200];
			toString(getOfferOnPos(res, i), str);
			printf("%s\n", str);
		}

	}
	destroyRepo(res);
}

void menuAscendingOrDescending()
{
	printf("1 - Ascending\n");
	printf("2 - Descending\n");
}


void startUI(UI* ui)
{
	while (1)
	{
		printMenu();
		int command = readIntegerNumber("Input command: ");
		while (validCommand(command) == 0)
		{
			printf("Please input a valid command!\n");
			command = readIntegerNumber("Input command: ");
		}
		if (command == 0)
			break;
		switch (command)
		{
		case 1:
		{
			int res = addOfferUI(ui);
			if (res == 1)
				printf("Offer successfully added.\n");
			else
				printf("Error! Offer could not be added, as there is another offer with the same destination and departure date!\n");
			break;
		}
		case 4:
		{
			listAllOffers(ui);
			break;
		}
		case 2:
		{
			int res = removeOfferUI(ui);
			if (res == 1)
				printf("Offer successfully removed.\n");
			else
				printf("Error! Offer could not be removed, as there is no such an offer with the same destination and departure date!\n");
			break;
		}
		case 3:
		{
			int res = updateOfferUI(ui);
			if (res == 1)
				printf("Offer successfully updated.\n");
			else
				printf("Error! Offer could not be updated!\n");
			break;
		}
		case 5:
		{
			menuAscendingOrDescending();
			printf("Choose an option: ");
			int option = 0;
			scanf("%d", &option);
			if (option == 1)
				listOffersByType(ui);
			if(option == 2)
				listOffersByType2(ui);
			break;
		}
		case 6:
		{
			menuAscendingOrDescending();
			printf("Choose an option: ");
			int option = 0;
			scanf("%d", &option);
			if (option == 1)
				listOffersByTypeForDate(ui);
			if (option == 2)
				listOffersByTypeForDate2(ui);
			break;
		}
		case 7:
		{
			filterByTypeLessThanAGivenPriceUi(ui);
			break;
		}
		case 8:
		{
			int res = undo(ui->ctrl);
			if (res == 1)
				printf("Undo was successful.\n");
			else
				printf("No more undos to be made.\n");
			break;
		}

		case 9:
		{
			int res = redo(ui->ctrl);
			if (res == 1)
				printf("Redo was successful.\n");
			else
				printf("No more redos to be made.\n");
			break;
		}
		}
	}
}