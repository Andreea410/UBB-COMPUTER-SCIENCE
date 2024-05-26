#define _CRT_SECURE_NO_WARNINGS
#include "Service.h"
#include <string.h>
#include <stdlib.h>

Controller* createController(OffersRepo* r, OperationsStack* undo, OperationsStack* redo)
{
	//Controller ctrl;
	Controller* ctrl = (Controller*)malloc(sizeof(Controller));
	ctrl->repo = r;
	ctrl->undo = undo;
	ctrl->redo = redo;
	return ctrl;
}

void destroyController(Controller* ctrl)
{
	// first destroy the repository inside
	destroyRepo(ctrl->repo);

	// then the operation stack
	destroyStack(ctrl->undo);

	// then the operation stack
	destroyStack(ctrl->redo);

	// then free the memory
	free(ctrl);
}


int addOfferCtrl(Controller* ctrl, char* type, char* destination, int day, char month[], double price)
{
	Offer* offer = createOffer(type, destination, day, month, price);

	int res = addOfferRepo(ctrl->repo, offer);
	if (res == 1) // if the planet was successfully added - register the operation
	{
		Operation* operation = createOperation(offer, "add");
		push(ctrl->undo, operation);
		// once added, the operation can be destroyed (a copy of the operation was added)
		destroyOperation(operation);
	}

	// destroy the planet that was just created, as the repository stored a copy
	destroyOffer(offer);

	return res;
}

int removeOfferCtrl(Controller* ctrl, char* destination, int day, char month[])
{
	Offer* offer = createOffer("Default", destination, day, month, 0);
	int res = removeByDestination(ctrl->repo, offer);

	if (res == 1) // if the planet was successfully removed - register the operation
	{
		Operation* operation = createOperation(offer, "remove");
		push(ctrl->undo, operation);
		// once added, the operation can be destroyed (a copy of the operation was added)
		destroyOperation(operation);
	}
	destroyOffer(offer);
	return res;
}

int updateOfferCtrl(Controller* ctrl, char* type, char* destination, int day, char month[], double price)
{
	Offer* offer = createOffer(type, destination, day, month, price);
	int res = update(ctrl->repo, offer);
	destroyOffer(offer);

	return res;
}

OffersRepo* getRepo(Controller* ctrl)
{
	return ctrl->repo;
}

OffersRepo* sortByPrice(Controller* ctrl)
{
	Offer* aux;
	for (int i = 0; i < getLength(ctrl->repo) - 1; i++)
	{
		for (int j = i + 1; j < getLength(ctrl->repo); j++)
		{
			if (ctrl->repo->offers->elemente[i]->price > ctrl->repo->offers->elemente[j]->price)
			{
				aux = ctrl->repo->offers->elemente[i];
				ctrl->repo->offers->elemente[i] = ctrl->repo->offers->elemente[j];
				ctrl->repo->offers->elemente[j] = aux;
			}
		}
	}

	return ctrl->repo;
}


OffersRepo* filterByDestination(Controller* ctrl, char destination[])
{
	OffersRepo* result = createRepo();
	//OffersRepo sorted = createRepo();
	ctrl->repo = sortByPrice(ctrl);
	if (strcmp(destination, "null") == 0)
	{
		return ctrl->repo;
	}

	for (int i = 0; i < getLength(ctrl->repo); i++)
	{
		Offer* offer = getOfferOnPos(ctrl->repo, i);
		if (strstr(offer->destination, destination) != NULL)
		{
			Offer* newOffer = createOffer(offer->type, offer->destination, offer->departureDate.day, offer->departureDate.month, offer->price);
			addOfferRepo(result, newOffer);
			destroyOffer(newOffer);
		}

	}
	return result;
}


OffersRepo* filterByType(Controller* ctrl, char type[])
{
	OffersRepo* result = createRepo();
	ctrl->repo = sortByDestination(ctrl);
	if (type[0] == '\0') 
	{
		return ctrl->repo;
	}
	size_t len = strlen(type);
	if(len > 0 && type[len - 1] == '\n') {
		type[len - 1] = '\0';
	}
	for (int i = 0; i < getLength(ctrl->repo); i++)
	{
		Offer* offer = getOfferOnPos(ctrl->repo, i);
		if (strstr(offer->type, type) != NULL || strstr(offer->destination , type)!=NULL)
		{
			Offer* newOffer = createOffer(offer->type, offer->destination, offer->departureDate.day, offer->departureDate.month, offer->price);
			addOfferRepo(result, newOffer);
			destroyOffer(newOffer);
		}
	}

	return result;
}

OffersRepo* filterByType2(Controller* ctrl, char type[])
{
	OffersRepo* result = createRepo();
	ctrl->repo = sortByDestination2(ctrl);
	if (type[0] == '\0')
	{
		return ctrl->repo;
	}
	size_t len = strlen(type);
	if (len > 0 && type[len - 1] == '\n') {
		type[len - 1] = '\0';
	}
	for (int i = 0; i < getLength(ctrl->repo); i++)
	{
		Offer* offer = getOfferOnPos(ctrl->repo, i);
		if (strstr(offer->type, type) != NULL || strstr(offer->destination, type) != NULL)
		{
			Offer* newOffer = createOffer(offer->type, offer->destination, offer->departureDate.day, offer->departureDate.month, offer->price);
			addOfferRepo(result, newOffer);
			destroyOffer(newOffer);
		}
	}

	return result;
}

OffersRepo* filterByTypeLessThanAGivenPrice(Controller* ctrl, char type[], double price)
{
	OffersRepo* result = createRepo();
	ctrl->repo = sortByPrice(ctrl);

	for (int i = 0; i < getLength(ctrl->repo); i++)
	{
		Offer* offer = getOfferOnPos(ctrl->repo, i);
		if (strstr(getType(offer), type) != NULL && offer->price <= price)
		{
			Offer* newOffer = createOffer(offer->type, offer->destination, offer->departureDate.day, offer->departureDate.month, offer->price);
			addOfferRepo(result, newOffer);
			destroyOffer(newOffer);
		}

	}

	return result;
}

OffersRepo* sortByDestination(Controller* ctrl)
{
	Offer* aux;// = createOffer("", "", 0, "", 0);
	for (int i = 0; i < getLength(ctrl->repo) - 1; i++)
	{
		for (int j = i + 1; j < getLength(ctrl->repo); j++)
		{
			if (ctrl->repo->offers->elemente[i]->price > ctrl->repo->offers->elemente[j]->price)
			{
				aux = ctrl->repo->offers->elemente[i];
				ctrl->repo->offers->elemente[i] = ctrl->repo->offers->elemente[j];
				ctrl->repo->offers->elemente[j] = aux;
			}
		}
	}
	//destroyOffer(aux);
	return ctrl->repo;
}

OffersRepo* sortByDestination2(Controller* ctrl)
{
	Offer* aux;// = createOffer("", "", 0, "", 0);
	for (int i = 0; i < getLength(ctrl->repo) - 1; i++)
	{
		for (int j = i + 1; j < getLength(ctrl->repo); j++)
		{
			if (ctrl->repo->offers->elemente[i]->price < ctrl->repo->offers->elemente[j]->price)
			{
				aux = ctrl->repo->offers->elemente[i];
				ctrl->repo->offers->elemente[i] = ctrl->repo->offers->elemente[j];
				ctrl->repo->offers->elemente[j] = aux;
			}
		}
	}
	//destroyOffer(aux);
	return ctrl->repo;
}

OffersRepo* sortByTypeFromAGivenDate(Controller* ctrl, char type[], int day, char month[])
{
	OffersRepo* result = createRepo();
	OffersRepo* result1 = createRepo();
	Offer* aux;
	ctrl->repo = sortByDestination(ctrl);
	if (strcmp(type, "null") == 0)
	{
		return ctrl->repo;
	}

	for (int i = 0; i < getLength(ctrl->repo); i++)
	{
		Offer* offer = getOfferOnPos(ctrl->repo, i);
		if (strstr(getType(offer), type) != NULL)
		{
			Offer* newOffer = createOffer(offer->type, offer->destination, offer->departureDate.day, offer->departureDate.month, offer->price);
			addOfferRepo(result, newOffer);
			destroyOffer(newOffer);
		}
		//destroyOffer(offer);
	}
	int month1 = 0;
	if (strcmp(month, "January") == 0)
		month1 = 1;
	if (strcmp(month, "February") == 0)
		month1 = 2;
	if (strcmp(month, "March") == 0)
		month1 = 3;
	if (strcmp(month, "April") == 0)
		month1 = 4;
	if (strcmp(month, "May") == 0)
		month1 = 5;
	if (strcmp(month, "June") == 0)
		month1 = 6;
	if (strcmp(month, "July") == 0)
		month1 = 7;
	if (strcmp(month, "August") == 0)
		month1 = 8;
	if (strcmp(month, "September") == 0)
		month1 = 9;
	if (strcmp(month, "October") == 0)
		month1 = 10;
	if (strcmp(month, "November") == 0)
		month1 = 11;
	if (strcmp(month, "December") == 0)
		month1 = 12;

	int m = 0;
	for (int j = 0; j < getLength(result); j++)
	{
		Offer* offer1 = getOfferOnPos(result, j);
		if (strcmp(offer1->departureDate.month, "January") == 0)
			m = 1;
		if (strcmp(offer1->departureDate.month, "February") == 0)
			m = 2;
		if (strcmp(offer1->departureDate.month, "March") == 0)
			m = 3;
		if (strcmp(offer1->departureDate.month, "April") == 0)
			m = 4;
		if (strcmp(offer1->departureDate.month, "May") == 0)
			m = 5;
		if (strcmp(offer1->departureDate.month, "June") == 0)
			m = 6;
		if (strcmp(offer1->departureDate.month, "July") == 0)
			m = 7;
		if (strcmp(offer1->departureDate.month, "August") == 0)
			m = 8;
		if (strcmp(offer1->departureDate.month, "September") == 0)
			m = 9;
		if (strcmp(offer1->departureDate.month, "October") == 0)
			m = 10;
		if (strcmp(offer1->departureDate.month, "November") == 0)
			m = 11;
		if (strcmp(offer1->departureDate.month, "December") == 0)
			m = 12;
		if ((offer1->departureDate.day >= day && m == month1) || (m > month1))
		{
			Offer* newOffer1 = createOffer(offer1->type, offer1->destination, offer1->departureDate.day, offer1->departureDate.month, offer1->price);
			addOfferRepo(result1, newOffer1);
			destroyOffer(newOffer1);
		}

	}
	//destroyRepo(result);
	for (int i = 0; i < getLength(result1) - 1; i++)
	{
		for (int j = i + 1; j < getLength(result1); j++)
		{
			if (result1->offers->elemente[i]->price > result1->offers->elemente[j]->price)
			{
				aux = result1->offers->elemente[i];
				result1->offers->elemente[i] = result1->offers->elemente[j];
				result1->offers->elemente[j] = aux;
			}
		}
	}
	return result1;
}

OffersRepo* sortByTypeFromAGivenDate2(Controller* ctrl, char type[], int day, char month[])
{
	OffersRepo* result = createRepo();
	OffersRepo* result1 = createRepo();
	Offer* aux;
	ctrl->repo = sortByDestination(ctrl);
	if (strcmp(type, "null") == 0)
	{
		return ctrl->repo;
	}

	for (int i = 0; i < getLength(ctrl->repo); i++)
	{
		Offer* offer = getOfferOnPos(ctrl->repo, i);
		if (strstr(getType(offer), type) != NULL)
		{
			Offer* newOffer = createOffer(offer->type, offer->destination, offer->departureDate.day, offer->departureDate.month, offer->price);
			addOfferRepo(result, newOffer);
			destroyOffer(newOffer);
		}
		//destroyOffer(offer);
	}
	int month1 = 0;
	if (strcmp(month, "January") == 0)
		month1 = 1;
	if (strcmp(month, "February") == 0)
		month1 = 2;
	if (strcmp(month, "March") == 0)
		month1 = 3;
	if (strcmp(month, "April") == 0)
		month1 = 4;
	if (strcmp(month, "May") == 0)
		month1 = 5;
	if (strcmp(month, "June") == 0)
		month1 = 6;
	if (strcmp(month, "July") == 0)
		month1 = 7;
	if (strcmp(month, "August") == 0)
		month1 = 8;
	if (strcmp(month, "September") == 0)
		month1 = 9;
	if (strcmp(month, "October") == 0)
		month1 = 10;
	if (strcmp(month, "November") == 0)
		month1 = 11;
	if (strcmp(month, "December") == 0)
		month1 = 12;

	int m = 0;
	for (int j = 0; j < getLength(result); j++)
	{
		Offer* offer1 = getOfferOnPos(result, j);
		if (strcmp(offer1->departureDate.month, "January") == 0)
			m = 1;
		if (strcmp(offer1->departureDate.month, "February") == 0)
			m = 2;
		if (strcmp(offer1->departureDate.month, "March") == 0)
			m = 3;
		if (strcmp(offer1->departureDate.month, "April") == 0)
			m = 4;
		if (strcmp(offer1->departureDate.month, "May") == 0)
			m = 5;
		if (strcmp(offer1->departureDate.month, "June") == 0)
			m = 6;
		if (strcmp(offer1->departureDate.month, "July") == 0)
			m = 7;
		if (strcmp(offer1->departureDate.month, "August") == 0)
			m = 8;
		if (strcmp(offer1->departureDate.month, "September") == 0)
			m = 9;
		if (strcmp(offer1->departureDate.month, "October") == 0)
			m = 10;
		if (strcmp(offer1->departureDate.month, "November") == 0)
			m = 11;
		if (strcmp(offer1->departureDate.month, "December") == 0)
			m = 12;
		if ((offer1->departureDate.day >= day && m == month1) || (m > month1))
		{
			Offer* newOffer1 = createOffer(offer1->type, offer1->destination, offer1->departureDate.day, offer1->departureDate.month, offer1->price);
			addOfferRepo(result1, newOffer1);
			destroyOffer(newOffer1);
		}

	}
	//destroyRepo(result);
	for (int i = 0; i < getLength(result1) - 1; i++)
	{
		for (int j = i + 1; j < getLength(result1); j++)
		{
			if (result1->offers->elemente[i]->price < result1->offers->elemente[j]->price)
			{
				aux = result1->offers->elemente[i];
				result1->offers->elemente[i] = result1->offers->elemente[j];
				result1->offers->elemente[j] = aux;
			}
		}
	}
	return result1;
}

int undo(Controller* ctrl)
{
	int res = 0;
	if (isEmpty(ctrl->undo))
	{
		return res;
	}

	Operation* operation = pop(ctrl->undo);
	push(ctrl->redo, operation);


	if (strcmp(getOperationType(operation), "add") == 0)
	{
		Offer* offer = getOffer(operation);
		char destination[50], month[20];
		int day = 0;
		strcpy(destination, offer->destination);
		strcpy(month, offer->departureDate.month);
		day = offer->departureDate.day;
		res = removeOfferCtrl(ctrl, destination, day, month);

	}
	else if (strcmp(getOperationType(operation), "remove") == 0)
	{
		Offer* offer = getOffer(operation);
		char destination[50], type[50], month[20];
		int day = 0;
		double price = 0;
		strcpy(type, offer->type);
		strcpy(destination, offer->destination);
		strcpy(month, offer->departureDate.month);
		day = offer->departureDate.day;
		price = offer->price;
		res = addOfferCtrl(ctrl, type, destination, day, month, price);

	}

	// the operation must be destroyed
	destroyOperation(operation);

	return res;

}


int redo(Controller* ctrl)
{
	int res = 0;
	if (isEmpty(ctrl->redo))
	{
		return res;
	}

	Operation* operation = pop(ctrl->redo);
	push(ctrl->undo, operation);


	if (strcmp(getOperationType(operation), "add") == 0)
	{

		Offer* offer = getOffer(operation);
		char destination[50], type[50], month[20];
		int day = 0;
		double price = 0;
		strcpy(type, offer->type);
		strcpy(destination, offer->destination);
		strcpy(month, offer->departureDate.month);
		day = offer->departureDate.day;
		price = offer->price;
		res = addOfferCtrl(ctrl, type, destination, day, month, price);
	}
	else if (strcmp(getOperationType(operation), "remove") == 0)
	{
		Offer* offer = getOffer(operation);
		char destination[50], month[20];
		int day = 0;
		strcpy(destination, offer->destination);
		strcpy(month, offer->departureDate.month);
		day = offer->departureDate.day;
		res = removeOfferCtrl(ctrl, destination, day, month);
	}

	// the operation must be destroyed
	destroyOperation(operation);

	return res;

}