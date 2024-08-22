
#include <iostream>
#include "Matrix.h"
#include "ExtendedTest.h"
#include "ShortTest.h"
#include <cassert>

using namespace std;


void test_newFunction()
{
	Matrix m(10, 10);
	for (int j = 0; j < 3; j++)
		m.modify(4, j, 3);
	pair<int, int> p = m.positionOf(3);
	assert(p.first == 4);
	pair<int, int>p2 = m.positionOf(5);
	assert(p2.first == -1);
}


int main() {


	testAll();
	testAllExtended();
	test_newFunction();
	cout << "Test End" << endl;
	system("pause");
}