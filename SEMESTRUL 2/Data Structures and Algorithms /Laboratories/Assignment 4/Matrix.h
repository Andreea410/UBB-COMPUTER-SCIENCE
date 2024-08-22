#pragma once
//DO NOT CHANGE THIS PART
typedef int TElem;
#define NULL_TELEM 0
#include <utility>

class Matrix {

private:
	//TODO - Representation
	
	
	
	struct HashNode {
		int row, col;
		TElem value;
		HashNode* next;
		HashNode(int r, int c, TElem v) : row(r), col(c), value(v), next(nullptr) {}
	};
	HashNode** hashTable;
	int hashTableSize;
	int nrLine;
	int nrCols;
	int nrElements;

	int hashFunction(int key) const;
	void resize();
	void insertOrdered(HashNode*& head, HashNode* newNode);

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

	std::pair<int,int> positionOf(TElem e) const;

	~Matrix();
	

};
