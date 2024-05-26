#pragma once

//We create a struct for date(int: day, char: month)
typedef struct {
	int day;
	char month[20];
}Date;


//We create a struct for an offer
typedef struct {
	char* type;
	char* destination;
	Date departureDate;
	double price;

}Offer;

//Offer createOffer1(char type[], char destination[], int day, char month[], double price);
Offer* createOffer(char* type, char* destination, int day, char month[], double price);

void destroyOffer(Offer* offer);
Offer* copyOffer(Offer* offer); // copy an offer and return a pointer to the copy

char* getType(Offer* offer);
char* getDestination(Offer* offer);
Date getDepartureDate(Offer* offer);
//Date getDepartureDateMonth(Offer *offer);
double getPrice(Offer* offer);

//This function was created for printing the offer using a patern
void toString(Offer* offer, char str[]);