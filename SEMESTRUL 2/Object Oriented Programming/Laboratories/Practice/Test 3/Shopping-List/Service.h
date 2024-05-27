#include "Repository.h"

class Service
{
private:
	Repository repo;
public:
	Service() {};
	Repository getRepo()
	{
		return this->repo;
	};
};