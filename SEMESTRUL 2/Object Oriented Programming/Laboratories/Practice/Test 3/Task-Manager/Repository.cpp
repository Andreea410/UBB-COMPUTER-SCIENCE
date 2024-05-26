#include "Repository.h"

void Repository::loadFromFile()
{
	this->tasks.clear();
	ifstream inputFile(this->filename);
	if (!inputFile.is_open())
		return;

	string line , description , priority,duration;
	while (getline(inputFile, line))
	{
		istringstream ss(line);
		getline(ss, description, ',');
		getline(ss, duration ,',');
		getline(ss, priority, ',');

		this->tasks.push_back(Task(description, stoi(duration), stoi(priority)));

	}
	inputFile.close();

}


void Repository::saveToFile()
{
	ofstream outputFile(this->filename);
	if (!outputFile.is_open())
		return;

	for (Task t : this->tasks)
	{
		outputFile << t.getDescription() << ","
			<< t.getDuration() << ","
			<< t.getPriority() << "\n";
	}

	outputFile.close();
}


vector<Task> Repository::sortTasks()
{
	loadFromFile();
	for (int i = 0; i < this->tasks.size() - 1; i++)
		for (int j = i; j < this->tasks.size(); j++)
			if (tasks[i].getPriority() > tasks[j].getPriority())
				swap(tasks[i], tasks[j]);
			else  if (tasks[i].getPriority() == tasks[j].getPriority())
				if(tasks[i].getDuration() > tasks[j].getDuration())
					swap(tasks[i], tasks[j]);
	saveToFile();
	return this->tasks;
}

