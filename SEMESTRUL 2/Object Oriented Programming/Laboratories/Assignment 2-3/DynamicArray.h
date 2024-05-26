#pragma once
#include "Offer.h"
#define CAPACITY 10

typedef Offer* TElement;
//typedef void(*DestroyElementFunctionType)(void*);

typedef struct
{
	TElement* elemente;
	int length;			// actual length of the array
	int capacity;		// maximum capacity of the array
	//DestroyElementFunctionType destroyElemFct; // function pointer to the function responsible with deallocating the elements stored in the array
} DynamicArray;


/// <summary>
/// Creates a dynamic array of generic elements, with a given capacity.
/// </summary>
/// <param name="capacity">Integer, maximum capacity for the dynamic array.</param>
/// <param name="destroyElemFct">Function pointer, of type DestroyElementFunctionType. The function that deals with deallocating the elements of the array.</param>
/// <returns>A pointer the the created dynamic array.</returns>
DynamicArray* createDynamicArray(int capacity);

/// <summary>
/// Destroys the dynamic array.
/// </summary>
/// <param name="vect">The dynamic array to be destoyed.</param>
/// <returns>A pointer the the created dynamic array.</returns>
void destroy(DynamicArray* vect);

/// <summary>
/// Adds a generic to the dynamic array.
/// </summary>
/// <param name="vect">The dynamic array.</param>
/// <param name="element">The offer to be added.</param>
void add(DynamicArray* vect, TElement element);

/// <summary>
/// Deletes an element from a given position in the dynamic array.
/// </summary>
/// <param name="vect">The dynamic array.</param>
/// <param name="pos">The position from which the element must be deleted. The position must be valid.</param>
void remove1(DynamicArray* vect, int pos);


/// <summary>
/// Update an element from a given position in the dynamic array.
/// </summary>
/// <param name="vect">The dynamic array.</param>
/// <param name="pos">The position from which the element must be deleted. The position must be valid.</param>
/// <param name="element">The offer to be added again.</param>
void updateDyn(DynamicArray* vect, TElement element, int pos);

/// <summary>
/// Returns the length of the dynamic array.
/// </summary>
/// <param name="vect">The dynamic array.</param>
int getLengthDyn(DynamicArray* vect);

/// <summary>
/// Returns the element on a given position.
/// </summary>
/// <param name="vect">The dynamic array.</param>
/// <param name="pos">The position - must be a valid position.</param>
/// <returns>The element on the given position.</returns>
TElement getElemFromPos(DynamicArray* vect, int pos);