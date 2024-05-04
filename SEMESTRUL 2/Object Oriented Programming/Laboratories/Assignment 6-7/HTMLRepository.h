#pragma once
#include "Repository.h"


class HTMLRepository: public Repository
{
public:
	HTMLRepository(const string &filename);
	void saveToFile() override;
	vector<Dog> loadFromFile() override;
};

