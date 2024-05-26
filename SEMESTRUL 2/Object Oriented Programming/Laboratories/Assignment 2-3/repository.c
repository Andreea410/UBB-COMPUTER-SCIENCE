#define _CRT_SECURE_NO_WARNINGS
#include "Repository.h"
#include "DynamicArray.h"
#include <stdlib.h>
#include <string.h>
#include <assert.h>

OffersRepo* createRepo()
{
	OffersRepo* v = (OffersRepo*)malloc(sizeof(OffersRepo));
	v->offers = createDynamicArray(CAPACITY);
	return v;
}

void destroyRepo(OffersRepo* v)
{
	if (v == NULL)
		return;

	// first destroy all the planets in the repository
	destroy(v->offers);
	free(v);
}


Offer* find(OffersRepo* v, char* destination, int day, char month[])
{
	if (v == NULL)
		return NULL;

	int pos = findPosOfOffer(v, destination, day, month);
	if (pos == -1)
		return NULL;

	return getElemFromPos(v->offers, pos);
}


int findPosOfOffer(OffersRepo* v, char* destination, char day, char month[])
{
	if (v == NULL)
		return -1;

	for (int i = 0; i < v->offers->length; i++)
	{
		Offer* offer = getElemFromPos(v->offers, i);
		if (strcmp(offer->destination, destination) == 0 && strcmp(offer->departureDate.month, month) == 0 && (offer->departureDate.day == day))
			return i;
	}
	return -1;
}


int addOfferRepo(OffersRepo* v, Offer* offer)
{
	if (v == NULL)
		return 0;

	// first search for an offer with the same destination and date as the one that is to be added and do not add it if it already exists
	if (find(v, offer->destination, offer->departureDate.day, offer->departureDate.month) != NULL)
		return 0;

	// a copy of the planet which was passed will be stored, such that the memory for the planet can be deallocated where it was allocated (in Controller) 
	// and the Repository will handle its own memory
	Offer* copy = copyOffer(offer);
	add(v->offers, copy);

	return 1;
}


int removeByDestination(OffersRepo* v, Offer* offer)
{
	if (v == NULL)
		return 0;

	// find the position of the offer in the repository
	int pos = findPosOfOffer(v, offer->destination, offer->departureDate.day, offer->departureDate.month);

	if (pos == -1)
		return 0;

	// destroy the offer
	//Offer* offer1 = getElemFromPos(v->offers, pos);
	//destroyOffer(offer1);

	// delete the pointer from the dynamic array
	remove1(v->offers, pos);

	return 1;
}


int update(OffersRepo* v, Offer* offer)
{
	if (find(v, offer->destination, offer->departureDate.day, offer->departureDate.month) == NULL)
		return 0;
	int pos = findPosOfOffer(v, offer->destination, offer->departureDate.day, offer->departureDate.month);
	updateDyn(v->offers, offer, pos);
	return 1;
}


int getLength(OffersRepo* v)
{
	if (v == NULL)
		return -1;

	return getLengthDyn(v->offers);
}

Offer* getOfferOnPos(OffersRepo* v, int pos)
{
	if (v == NULL)
		return NULL;

	if (pos < 0 || pos >= getLengthDyn(v->offers))
		return NULL;

	return getElemFromPos(v->offers, pos);
}

//TESTS

void testAdd()
{
	Offer* offer = createOffer("city break", "Sibiu", 2, "May", 200);
	Offer* offer1 = createOffer("city break", "Viena", 19, "March", 200);
	OffersRepo* v = createRepo();

	//initOffersRepoForTests(v);

	assert(addOfferRepo(v, offer1) == 1);
	assert(getLength(v) == 1);
	//assert(strcmp(getDestination(getOfferOnPos(v, 0)), "Viena") == 0);

	assert(addOfferRepo(v, offer) == 1);
	assert(getLength(v) == 2);

	//assert(removeByDestination(v, offer) == 1);
	//assert(getLength(v) == 1);

	// now try to add the same planet again -> add must return 0
	//assert(add(v, offer) == 0);

	destroyOffer(offer);
	destroyOffer(offer1);
	destroyRepo(v);
}

void testsOffersRepo()
{
	testAdd();
}