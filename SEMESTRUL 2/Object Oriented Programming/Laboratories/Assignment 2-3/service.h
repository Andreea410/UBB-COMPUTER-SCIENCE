#pragma once
#include "Repository.h"
#include "OperationsStack.h"

typedef struct
{
	OffersRepo* repo;
	OperationsStack* undo;
	OperationsStack* redo;
} Controller;


//This function creates a Controller
Controller* createController(OffersRepo* r, OperationsStack* undo, OperationsStack* redo);


//This function destroy the Controller(este in legatura cu destroyRepo)
void destroyController(Controller* ctrl);

/// <summary>
/// Adds an offer to the repository of offers.
/// </summary>
/// <param name="ctrl">Pointer to theController.</param>
/// <param name = "type">A string, the type of the offer.</param>
/// <param name = "destination">A string, the offer's destination.</param>
/// <param name = "day">An integer representing the offer's day.</param>
/// <param name = "month">A string representing the offer's month.</param>
/// <param name = "price">Double, the price of the offer</param>
/// <returns>1 - if the offer was sucessfully added; 0 - if the offer could not be added, as another offer with the same details already exists.</returns>
int addOfferCtrl(Controller* ctrl, char* type, char* destination, int day, char month[], double price);


/// <summary>
/// Remove an offer to the repository of offers.
/// </summary>
/// <param name="ctrl">Pointer to theController.</param>
/// <param name = "destination">A string, the offer's destination.</param>
/// <param name = "day">An integer representing the offer's day.</param>
/// <param name = "month">A string representing the offer's month.</param>
/// <returns>1 - if the offer was sucessfully removed; 0 - if the offer could not be removes,because does not exists.</returns>
int removeOfferCtrl(Controller* ctrl, char* destination, int day, char month[]);


//This function returns a repo
OffersRepo* getRepo(Controller* ctrl);


/// <summary>
/// Searches for the offers for a given destination.
/// </summary>
/// <param name="ctrl">Pointer to the Controller.</param>
/// <param name = "destination">A string, the searched destination; "null" - for all the destinations.</param>
/// <returns>A repository of offers, that have the given destination.</returns>
OffersRepo* filterByDestination(Controller* ctrl, char destination[]);


//This function sort a repo of offers by price
OffersRepo* sortByPrice(Controller* ctrl);

/// <summary>
/// Searches for the offers for a given type(sorted by destination).
/// </summary>
/// <param name="ctrl">Pointer to the Controller.</param>
/// <param name = "type">A string, the searched type; "null" - for all types.</param>
/// <returns>A repository of offers, that have the given type.</returns>
OffersRepo* filterByType(Controller* ctrl, char type[]);
OffersRepo* filterByType2(Controller* ctrl, char type[]);

/// <summary>
/// Searches for the offers for a given type(less than a given price).
/// </summary>
/// <param name="ctrl">Pointer to the Controller.</param>
/// <param name = "type">A string, the searched type.</param>
/// <param name = "price">Double, the bigest price(all values must be less than this value).</param>
/// <returns>A repository of offers, that have the given type(sorted by price).</returns>
OffersRepo* filterByTypeLessThanAGivenPrice(Controller* ctrl, char type[], double price);

//This function sort a repo of offers by destination(alphabeticaly)
OffersRepo* sortByDestination(Controller* ctrl);
OffersRepo* sortByDestination2(Controller* ctrl);


/// <summary>
/// Searches for the offers for a given type(from a givem date).
/// </summary>
/// <param name="ctrl">Pointer to the Controller.</param>
/// <param name = "type">A string, the searched type; "null" - for all types.</param>
/// <param name = "day">An integer, the searched day.</param>
/// <param name = "month">A string, the searched month.</param>
/// <returns>A repository of offers, that have the given type(from that given date).</returns>
OffersRepo* sortByTypeFromAGivenDate(Controller* ctrl, char type[], int day, char month[]);
OffersRepo* sortByTypeFromAGivenDate2(Controller* ctrl, char type[], int day, char month[]);

//This function update an offer(wh can change the type and the price, but we can't change the ID(destination, date))
int updateOfferCtrl(Controller* ctrl, char* type, char* destination, int day, char month[], double price);

//This function undo the last operation
int undo(Controller* ctrl);

//This function redo the last operation
int redo(Controller* ctrl);