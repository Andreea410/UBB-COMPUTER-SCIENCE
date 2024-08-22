#pragma once

#include <utility>

//DO NOT CHANGE THIS PART
typedef int TElem;
typedef std::pair<int, int>position;
#define NULL_TELEM (-111111)
#define NULL_position std::pair<int,int>(-111111,-111111)
class Matrix {

private:
	int capacity;
	int lines;
	int columns;
	TElem* values;
	position* positions;
	int* left;
	int* right;
	int root;
	int firstFree;
	int* nrColumn;
public:
	//constructor
	Matrix(int nrLines, int nrCols);

	//returns the number of lines
	int nrLines() const;

	//returns the number of columns
	int nrColumns() const;

	//returns the element from line i and column j (indexing starts from 0)
	//throws exception if (i,j) is not a valid position in the Matrix
	TElem element(int i, int j) const;

	//modifies the value from line i and column j
	//returns the previous value from the position
	//throws exception if (i,j) is not a valid position in the Matrix
	TElem modify(int i, int j, TElem e);
	void addElem(int i, int j, TElem e, int pos, int father, TElem& toReturn);
	void resize();
	bool relation(int i1, int j1, int i2, int j2) const;
	void transpose();
	~Matrix();

	void displayElements();
};