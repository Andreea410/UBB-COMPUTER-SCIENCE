#pragma once
#include "Domain.h"
#include <vector>
#include <fstream>
#include <sstream>


class Repository
{
private:
	vector<Task> tasks;
	string filename = "tasks.txt";
public:
	Repository() {};
	vector<Task> getTasks() { loadFromFile(); return this->tasks; }
	void loadFromFile();
	void saveToFile();
	vector<Task> sortTasks();

};

