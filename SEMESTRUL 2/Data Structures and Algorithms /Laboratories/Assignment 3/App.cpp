#include <iostream>
#include "ShortTest.h"
#include "ExtendedTest.h"
#include "IndexedList.h"
#include <cassert>

using namespace std;

void testExtraFunction()
{
    IndexedList list;
    TElem e = 5;
    list.addToPosition(0, e);
    list.addToPosition(1, 2);
    list.addToPosition(2, 10);
    list.addToPosition(3, 7);
    assert(list.valueBetweenLargestAndSmallest() == 8);

    cout << "Test ended";
}
int main(){
    testAll();
    testAllExtended();
    cout<<"Finished LI Tests!"<<endl;
}