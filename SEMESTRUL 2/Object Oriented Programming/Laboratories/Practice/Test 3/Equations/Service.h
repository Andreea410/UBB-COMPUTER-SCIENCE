#pragma once
#include "Repository.h"

class Service
{
private:
	Repository repo;
public:
	Service() { Repository(); };
	Repository getRepo() { return this->repo; }
	void updateEq(int index, Equation eq);
};

