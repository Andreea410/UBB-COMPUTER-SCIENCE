#pragma once
#include "Observer.h"
#include <iostream>
#include <vector>
using namespace std;

class Subject
{
private:
	vector<Observer*>observers;
public:
	void addObserver(Observer* ob)
	{
		observers.push_back(ob);
	}

	void notify()
	{
		for (Observer* ob : observers)
			ob->update();
	}
};

