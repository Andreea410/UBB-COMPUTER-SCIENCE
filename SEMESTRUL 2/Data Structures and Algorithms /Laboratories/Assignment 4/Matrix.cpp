#include "Matrix.h"
#include <exception>
#include <iostream>
#include <utility>
using namespace std;

//best case: theta(1), worst case: theta(n)
Matrix::Matrix(int nrLines, int nrCols) {
    hashTableSize = 10;
    hashTable = new HashNode * [hashTableSize];
    for (int i = 0; i < hashTableSize; i++)
        hashTable[i] = nullptr;
    nrElements = 0;
    this->nrLine = nrLines;
    this->nrCols = nrCols;
}
//best case : theta(1), worst case: theta(n)
Matrix::~Matrix() {
    for (int i = 0; i < hashTableSize; i++) {
        HashNode* current = hashTable[i];
        while (current != nullptr) {
            HashNode* toDelete = current;
            current = current->next;
            delete toDelete;
        }
    }
    delete[] hashTable;
}

//best case : theta(1), worst case: theta(1)
int Matrix::hashFunction(int key) const {
    return key % hashTableSize;
}

//best case : theta(n), worst case: theta(n^2)
void Matrix::resize() {
    int newHashTableSize = hashTableSize * 2;
    HashNode** newHashTable = new HashNode * [newHashTableSize];
    for (int i = 0; i < newHashTableSize; i++)
        newHashTable[i] = nullptr;

    int oldHashTableSize = hashTableSize;
    hashTableSize = newHashTableSize;
    for (int i = 0; i < oldHashTableSize; i++) {
        HashNode* current = hashTable[i];
        while (current != nullptr) {
            HashNode* next = current->next;
            int pos = hashFunction(current->row * nrCols + current->col);
            current->next = newHashTable[pos];
            newHashTable[pos] = current;
            current = next;
        }
    }
    delete[] hashTable;
    hashTable = newHashTable;
}

//best case : theta(1), worst case: theta(n)
void Matrix::insertOrdered(HashNode*& head, HashNode* newNode) {
    if (head == nullptr || (newNode->row < head->row || (newNode->row == head->row && newNode->col < head->col))) {
        newNode->next = head;
        head = newNode;
    }
    else {
        HashNode* current = head;
        while (current->next != nullptr && (current->next->row < newNode->row || (current->next->row == newNode->row && current->next->col < newNode->col))) {
            current = current->next;
        }
        newNode->next = current->next;
        current->next = newNode;
    }
}

//best case : theta(1), worst case: theta(1)
int Matrix::nrLines() const {
    return this->nrLine;
}

//best case : theta(1), worst case: theta(1)
int Matrix::nrColumns() const {
    return this->nrCols;
}

//best case : theta(1), worst case: theta(n)
TElem Matrix::element(int i, int j) const {
    if (i < 0 || i >= this->nrLine || j < 0 || j >= this->nrCols)
        throw exception("Invalid position");
    int pos = hashFunction(i * this->nrCols + j);
    HashNode* current = hashTable[pos];
    while (current != nullptr) {
        if (current->row == i && current->col == j)
            return current->value;
        current = current->next;
    }
    return NULL_TELEM;
}
//best case Theta(n)
//worst case Theta(n^2)
TElem Matrix::modify(int i, int j, TElem e) {
    if (i < 0 || i >= this->nrLine || j < 0 || j >= this->nrCols)
        throw exception("Invalid position");
    int pos = hashFunction(i * this->nrCols + j);
    HashNode* current = hashTable[pos];
    while (current != nullptr) {
        if (current->row == i && current->col == j) {
            TElem oldValue = current->value;
            if (e == NULL_TELEM) {
                // Remove the node
                HashNode* temp = current;
                if (temp == hashTable[pos]) {
                    hashTable[pos] = current->next;
                }
                else {
                    HashNode* prev = hashTable[pos];
                    while (prev->next != current) {
                        prev = prev->next;
                    }
                    prev->next = current->next;
                }
                delete temp;
                nrElements--;
            }
            else {
                current->value = e;
            }
            return oldValue;
        }
        current = current->next;
    }
    if (e != NULL_TELEM) {
        HashNode* newNode = new HashNode(i, j, e);
        insertOrdered(hashTable[pos], newNode);
        nrElements++;
        if (nrElements == hashTableSize) {
            resize();
        }
    }
    return NULL_TELEM;
}

//best case : theta(1), worst case: theta(n)
pair<int, int> Matrix::positionOf(TElem e) const {
	for (int i = 0; i < hashTableSize; i++) {
		HashNode* current = hashTable[i];
		while (current != nullptr) {
			if (current->value == e) {
				return make_pair(current->row, current->col);
			}
			current = current->next;
		}
	}
	return make_pair(-1, -1);
}
