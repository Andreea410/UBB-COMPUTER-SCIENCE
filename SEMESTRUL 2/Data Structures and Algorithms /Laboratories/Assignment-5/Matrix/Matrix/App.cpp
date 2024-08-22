#include <iostream>
#include "Matrix.h"
#include "ExtendedTest.h"
#include "ShortTest.h"
#include <cassert>
using namespace std;
void testNewFunction()
{
    Matrix squareMatrix(2, 2);
    squareMatrix.modify(0, 0, 1);
    squareMatrix.modify(0, 1, 2);
    squareMatrix.modify(1, 0, 3);
    squareMatrix.modify(1, 1, 4);
    squareMatrix.transpose();
    assert(squareMatrix.nrLines() == 2);
    assert(squareMatrix.nrColumns() == 2);
    assert(squareMatrix.element(0, 0) == 1);
    assert(squareMatrix.element(0, 1) == 3);
    assert(squareMatrix.element(1, 0) == 2);
    assert(squareMatrix.element(1, 1) == 4);
  
}

int main() {

    
    testAll();
    testAllExtended();
    testNewFunction();
    cout << "Test End" << endl;
    system("pause");
}