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
	void loadFromFile()
	{
		this->tasks.clear();
		ifstream input(filename);
		string line, description, duration, priority;
		while (getline(input, line))
		{
			istringstream ss(line);
			getline(ss, description, ',');
			getline(ss, duration, ',');
			getline(ss, priority, ',');
			this->tasks.push_back(Task(description, stoi(duration), stoi(priority)));

		}
	};
	vector<Task> getTasks()
	{
		loadFromFile();
		for (int i = 0; i < tasks.size() - 1; i++)
			for (int j = i; j < tasks.size(); j++)
				if (tasks[i].getPriority() > tasks[j].getPriority())
					swap(tasks[i], tasks[j]);
				else if(tasks[i].getPriority() == tasks[j].getPriority())
					if (tasks[i].getDuration() > tasks[j].getDuration())
						swap(tasks[i], tasks[j]);
		return this->tasks;
	};
};
