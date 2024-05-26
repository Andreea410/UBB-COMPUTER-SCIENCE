#include "DynamicArray.h"
#include <stdlib.h>
#include <assert.h>

DynamicArray* createDynamicArray(int capacity)
{
	DynamicArray* dynArr = (DynamicArray*)malloc(sizeof(DynamicArray));
	// make sure that the space was allocated
	if (dynArr == NULL)
		return NULL;

	dynArr->capacity = capacity;
	dynArr->length = 0;

	// allocate space for the elements
	dynArr->elemente = (TElement*)malloc(capacity * sizeof(TElement));

	if (dynArr->elemente == NULL)
		return NULL;

	return dynArr;
}

void destroy(DynamicArray* vect)
{
	if (vect == NULL)
		return;

	// deallocate each of the elements
	for (int i = 0; i < vect->length; i++)
		destroyOffer(vect->elemente[i]);

	// free the space allocated for the elements
	free(vect->elemente);
	vect->elemente = NULL;

	// free the space allocated for the dynamic array
	free(vect);
	vect = NULL;
}

// Resizes the array, allocating more space.
// If more space cannot be allocated, returns -1, else it returns 0.
int resize(DynamicArray* vect)
{
	if (vect == NULL)
		return -1;

	vect->capacity *= 2;

	//allocate new memory, copy everything and deallocate the old memory
	TElement* aux = (TElement*)malloc(vect->capacity * sizeof(TElement));
	if (aux == NULL)
		return -1;
	for (int i = 0; i < vect->length; i++)
		aux[i] = vect->elemente[i];
	free(vect->elemente);
	vect->elemente = aux;

	return 0;
}

void add(DynamicArray* vect, TElement element)
{
	if (vect == NULL)
		return;
	if (vect->elemente == NULL)
		return;

	// resize the array, if necessary
	if (vect->length == vect->capacity)
		resize(vect);
	vect->elemente[vect->length++] = element;
}

void remove1(DynamicArray* vect, int pos)
{
	if (vect == NULL)
		return;

	if (vect->elemente == NULL)
		return;

	if (pos < 0 || pos >= vect->length)
		return;

	// deallocate the memory of the element on position pos
	destroyOffer(vect->elemente[pos]);
	//vect->destroyElemFct(vect->elemente[pos]);

	for (int i = pos; i < vect->length - 1; i++)
		vect->elemente[i] = vect->elemente[i + 1];

	vect->length--;
}

void updateDyn(DynamicArray* vect, TElement element, int pos)
{
	remove1(vect, pos);
	add(vect, element);
}

int getLengthDyn(DynamicArray* vect)
{
	if (vect == NULL)
		return -1;

	return vect->length;
}

TElement getElemFromPos(DynamicArray* vect, int pos)
{
	return vect->elemente[pos];
}