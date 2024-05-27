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
	Task();
	Task(string description, int duration, int priority)
	{
		this->description = description;
		this->duration = duration;
		this->priority = priority;
	};

	string getDescription()
	{
		return this->description;
	};

	int getDuration()
	{
		return this->duration;
	};

	int getPriority()
	{
		return this->priority;
	};

	string toStr()
	{
		string result = this->getDescription() + " | "
			+ to_string(this->getDuration()) + " | "
			+ to_string(this->getPriority());
		return result;
	};
};
