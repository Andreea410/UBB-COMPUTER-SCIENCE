#pragma once

#include "Dog.h"

template<typename TElem>
class DynamicArray
{
public:
	//default constructor
	DynamicArray(int capacity = 10);

	DynamicArray(const DynamicArray& v);

	//destructor
	~DynamicArray();

private:
	TElem *elems;
	int size;
	int capacity;
public:
	
	DynamicArray &operator =(const DynamicArray& v);

	int getSize() const;
	TElem getElement(int pos);
	void addElement(const TElem &e);
	void removeElement(int pos);
	void updateElement(int pos , const TElem &newElem);

	private:
		void resize(int factor = 2);
};

template<typename TElem>
DynamicArray<TElem>::DynamicArray(int capacity)
{
	this->size = 0;
	this->capacity = capacity;
	this->elems = new TElem[capacity];
}

template<typename TElem>
DynamicArray<TElem>::DynamicArray(const DynamicArray<TElem>& v) {
	this->size = v.size;
	this->capacity = v.capacity;
	this->elems = new TElem[this->capacity];
	for (int i = 0; i < this->size; i++)
		this->elems[i] = v.elems[i];
}

template<typename TElem>
DynamicArray<TElem>::~DynamicArray() {
	delete[] this->elems;
}

template<typename TElem>
DynamicArray<TElem>& DynamicArray<TElem>::operator=(const DynamicArray <TElem>& v)
{
	if (this == &v)
		return *this;
	this->size = v.size;
	this->capacity = v.capacity;

	delete[] this->elems;
	this->elems = new TElem[this->capacity];
	for (int i = 0; i < this->size; i++)
		this->elems[i] = v.elems[i];

	return *this;
}

template<typename TElem>
int DynamicArray<TElem>::getSize() const
{
	return this->size;
}

template<typename TElem>
TElem DynamicArray<TElem>::getElement(int pos)
{
	return this->elems[pos];
}

template<typename TElem>
void DynamicArray<TElem>::addElement(const TElem &e)
{
	if (this->size == this->capacity)
		this->resize();
	this->elems[this->size] = e;
	this->size++;
}

template<typename TElem>
void DynamicArray<TElem>::removeElement(int pos)
{
	for (int i = pos; i < this->size - 1; i++)
		this->elems[i] = this->elems[i+1];
	this->size--;
}

template<typename TElem>
void DynamicArray<TElem>::updateElement(int pos , const TElem &new_elem)
{
	this->elems[pos] = new_elem;
}

template<typename TElem>
void DynamicArray<TElem>::resize(int factor)
{
	this->capacity *= factor;
	auto *els = new TElem[this->capacity];
	for(int i= 0 ; i <this->size ; i++)
		els[i] = this->elems[i];

	delete[] this->elems;
	this->elems = els;
}