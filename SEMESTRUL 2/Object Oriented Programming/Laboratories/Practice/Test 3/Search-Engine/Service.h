#pragma once
#include "Repository.h"


class Service
{
private:
	Repository repo;
public:
	Repository getRepo() { return this->repo; };
	Service() {};
	Document getBestMatch(string str);
};

