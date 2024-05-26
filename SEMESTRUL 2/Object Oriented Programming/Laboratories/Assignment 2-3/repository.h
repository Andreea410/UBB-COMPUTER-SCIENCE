#pragma once
#include "Offer.h"
#include "DynamicArray.h"

//typedef struct {
//	Offer* offers[100];
//	int length;
//}OffersRepo;

typedef struct
{
	DynamicArray* offers;

} OffersRepo;

/// <summary>
/// Creates a OffersRepo.
/// </summary>
OffersRepo* createRepo();


/// <summary>
/// Destroys a given offers repository. The memory is freed.
/// </summary>
void destroyRepo(OffersRepo* v);


/// <summary>
/// Finds am offer for given destination.
/// </summary>
/// <param name="v">Pointer to the OffersRepo.</param>
/// <param name = "destination">A string, the destination to search for.</param>
/// <param name = "day">An integer, the departure day to search for.</param>
/// <param name = "month">A string, the departure month to search for.</param>
/// <returns>pos - the position on which the offer for that given destination is in the OffersRepo; -1 - if the offer does not exist.</returns>
Offer* find(OffersRepo* v, char* destination, int day, char month[]);

/*
Adds an offer to the repository of offers.
Input:	- v - pointer to the OffersRepo
- offer - the offer
Output: 1 - if the offer was sucessfully added
0 - if the offer could not be added, as another offer with the same symbol already exists in the OffersRepo.
*/
int addOfferRepo(OffersRepo* v, Offer* offer);


/*
Remove an offer from the repository of offers.
Input:	- v - pointer to the OffersRepo
- offer - the offer
Output: 1 - if the offer was sucessfully removed
0 - if the offer could not be removed
*/
int removeByDestination(OffersRepo* v, Offer* offer);


/*
Update an offer to the repository of offers.
Input:	- v - pointer to the OffersRepo
- offer - the offer
Output: 1 - if the offer was sucessfully updated
0 - if the offer could not be updated, as another offer with the same symbol does not exists in the OffersRepo.
*/
int update(OffersRepo* v, Offer* offer);

/*Return the length of the Repository*/
int getLength(OffersRepo* v);

/*
Returns the offer on the given position in the offers vector.
Input:	v - the offers repository;
pos - integer, the position;
Output: the offer on the given potision, or an "empty" offer.
*/
Offer* getOfferOnPos(OffersRepo* v, int pos);

int findPosOfOffer(OffersRepo* v, char* destination, char day, char month[]);


void testsOffersRepo();