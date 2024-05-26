#pragma once
#include "Repository.h"

class Service
{
private:
	Repository repo;
public:
	Service() {};
	Repository getRepo() { return this->repo; };
	double getTotal(string name)
	{
		return this->repo.calculateAll(name);
	};
};

