#include "Domain.h"

Task::Task(string description, int duration, int priority)
{
	this->description = description;
	this->duration = duration;
	this->priority = priority;
}

string Task::getDescription()
{
	return this->description;
}

int Task::getDuration()
{
	return this->duration;
}

int Task::getPriority()
{
	return this->priority;
}

string Task::toStr() const
{
	string str = "";
	str += this->description + " " +to_string(this->duration) + " "+  to_string(this->priority);
	return str;
}