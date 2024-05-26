#define _CRT_SECURE_NO_WARNINGS
#include "Offer.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


//Offer createOffer1(char type[], char destination[], int day, char month[], double price)
//{
//	Offer offer;
//	strcpy(offer.type, type);
//	strcpy(offer.destination, destination);
//	offer.departureDate.day = day;
//	strcpy(offer.departureDate.month, month);
//	offer.price = price;
//
//	return offer;
//}


Offer* createOffer(char* type, char* destination, int day, char month[], double price)
{
	Offer* offer = (Offer*)malloc(sizeof(Offer));
	if (offer == NULL)
		return NULL;
	offer->destination = (char*)malloc(sizeof(char) * (strlen(destination) + 1));
	strcpy(offer->destination, destination);
	offer->type = (char*)malloc(sizeof(char) * (strlen(type) + 1));
	strcpy(offer->type, type);
	offer->departureDate.day = day;
	//offer->departureDate.month = (char*)malloc(sizeof(char)*(strlen(month) + 1));
	strcpy(offer->departureDate.month, month);
	offer->price = price;

	return offer;
}


void destroyOffer(Offer* offer)
{
	if (offer == NULL)
		return;
	// free the memory which was allocated for the component fields
	free(offer->destination);
	offer->destination = NULL;
	free(offer->type);
	offer->type = NULL;

	// free the memory which was allocated for the offer structure
	free(offer);
	offer = NULL;
}


Offer* copyOffer(Offer* offer)
{
	if (offer == NULL)
		return NULL;

	Offer* newOffer = createOffer(getType(offer), getDestination(offer), offer->departureDate.day, offer->departureDate.month, getPrice(offer));
	return newOffer;
}

char* getDestination(Offer* offer)
{
	return offer->destination;
}

char* getType(Offer* offer)
{
	return offer->type;
}

Date getDepartureDate(Offer* offer)
{
	return offer->departureDate;
}


double getPrice(Offer* offer)
{
	return offer->price;
}

void toString(Offer* offer, char str[])
{
	sprintf(str, "\n Offer for %s:\n Destination: %s\n Date: %d.%s\n Price: %.2lf\n", offer->type, offer->destination, offer->departureDate.day, offer->departureDate.month, offer->price);
}