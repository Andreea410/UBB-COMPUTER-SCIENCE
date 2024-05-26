#include "Service.h"

Document Service::getBestMatch(string str)
{
	return this->repo.getBestMatch(str);
}