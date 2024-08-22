#include "Matrix.h"
#include <exception>
#include <iostream>
using namespace std;


Matrix::Matrix(int nrLines, int nrCols) {

    lines = nrLines;
    columns = nrCols;
    firstFree = 0;
    capacity = 2;
    values = new TElem[capacity];
    left = new int[capacity];
    right = new int[capacity];
    root = -1;
    nrColumn = new int[columns];
    for (int i = 0; i < columns; ++i) {
        nrColumn[i] = 0;
    }
    positions = new std::pair<int, int>[capacity];
    for (int i = 0; i < capacity; ++i) {
        values[i] = NULL_TELEM;
        left[i] = -1;
        right[i] = -1;
        positions[i] = NULL_position;
    }
}
//Theta(1)

int Matrix::nrLines() const {
    return lines;
}
//Theta(1)

int Matrix::nrColumns() const {
    return columns;
}
//Theta(1)

TElem Matrix::element(int i, int j) const {

    if (i < 0 or j < 0 or i >= lines or j >= columns)
        throw exception();
    bool found = false;
    int current = root;
    while (current != -1 && !found) {
        if (positions[current].first == i && positions[current].second == j)
            found = true;
        else if (this->relation(i, j, positions[current].first, positions[current].second))
            current = left[current];
        else
            current = right[current];
    }
    if (found)
        return values[current];
    return NULL_TELEM;
}
//Theta(logn)

//best case : Theta(1)
//Worst case : Theta(n)
TElem Matrix::modify(int i, int j, TElem e) {
    if (i < 0 or j < 0 or i >= lines or j >= columns)
        throw exception();
    if (firstFree == capacity)
        resize();
    if (root == -1)
    {
        root = 0;
        firstFree++;
        values[root] = e;
        positions[root] = std::pair<int, int>(i, j);
        nrColumn[j] += 1;
        return NULL_TELEM;
    }
    TElem toReturn = NULL_TELEM;
    addElem(i, j, e, root, -1, toReturn);
    return toReturn;

}


//Best case: Theta(1)
//Worst case :Theta(n) 
void Matrix::addElem(int i, int j, TElem e, int pos, int father, TElem& torReturn) {
    if (pos == -1) {
        values[firstFree] = e;
        positions[firstFree] = std::pair<int, int>(i, j);
        nrColumn[j] += 1;
        if (relation(i, j, positions[father].first, positions[father].second))
            left[father] = firstFree;
        else
            right[father] = firstFree;
        firstFree++;
        torReturn = NULL_TELEM;
    }
    else {
        if (positions[pos].first == i && positions[pos].second == j) {
            torReturn = values[pos];
            values[pos] = e;
        }
        else {
            if (relation(i, j, positions[pos].first, positions[pos].second))
                addElem(i, j, e, left[pos], pos, torReturn);
            else
                addElem(i, j, e, right[pos], pos, torReturn);

        }
    }
}

//Theta(n)
void Matrix::resize() {
    TElem* newValues = new TElem[capacity * 2];
    position* newPositions = new position[capacity * 2];
    int* newLeft = new int[capacity * 2];
    int* newRight = new int[capacity * 2];
    for (int i = 0; i < capacity * 2; ++i) {
        newValues[i] = NULL_TELEM;
        newPositions[i] = NULL_position;
        newLeft[i] = -1;
        newRight[i] = -1;
    }
    for (int i = 0; i < capacity; ++i) {
        newValues[i] = values[i];
        newPositions[i].first = positions[i].first;
        newPositions[i].second = positions[i].second;
        newLeft[i] = left[i];
        newRight[i] = right[i];
    }
    capacity = capacity * 2;
    delete[] values;
    delete[] positions;
    delete[] left;
    delete[] right;
    values = newValues;
    left = newLeft;
    right = newRight;
    positions = newPositions;
}

//Theta(1)
bool Matrix::relation(int i1, int j1, int i2, int j2) const {
    if (i1 == i2)
        return j2 <= j1;
    return i2 < i1;
}

Matrix::~Matrix() {
    delete[] values;
    delete[] positions;
    delete[] left;
    delete[] right;
}

void Matrix::transpose() {
   
    int* newLeft = new int[capacity];
    int* newRight = new int[capacity];
    pair<int, int>* newPositions = new std::pair<int, int>[capacity];
    TElem* newValues = new TElem[capacity];

   Matrix transposedMatrix(this->columns , this->lines);
   transposedMatrix.capacity = this->capacity;
   transposedMatrix.lines = this->columns; 
   transposedMatrix.columns = this->lines; 
   transposedMatrix.left = newLeft;
   transposedMatrix.right = newRight;
   transposedMatrix.positions = newPositions;
   transposedMatrix.values = newValues;


    for(int j = 0;j < columns ; j++)
        for (int i = 0; i < lines; i++)
        {
            TElem value = this->element(i, j);
            if (value != 0) {
                TElem toReturn = NULL_TELEM;
                transposedMatrix.addElem(j, i, value,root,-1,toReturn);
            }
        }

    lines = columns;
    columns = lines;
    firstFree = 0;
    capacity = transposedMatrix.capacity;
    values = newValues;
    left = newLeft;
    right = newRight;
    root = transposedMatrix.root;
    nrColumn = transposedMatrix.nrColumn;
    positions = transposedMatrix.positions;

    displayElements();
       
}


void Matrix::displayElements()
{
       for (int i = 0; i < lines; i++) 
       {
           for (int j = 0; j < columns; j++)
           {
               TElem elem = element(i, j);
               if (elem != NULL_TELEM )
                   cout << i << ", " << j << " = " << elem << endl;
           }
       }

}
