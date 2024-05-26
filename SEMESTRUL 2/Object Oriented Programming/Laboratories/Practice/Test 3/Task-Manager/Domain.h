#pragma once
#include <string>
#include <string.h>

using namespace std;

class Task
{
private:
	string description;
	int duration;
	int priority;
public:
	Task() {};
	Task(string description, int duration, int priority);
	string getDescription();
	int getDuration();
	int getPriority();
	string toStr() const;

};

