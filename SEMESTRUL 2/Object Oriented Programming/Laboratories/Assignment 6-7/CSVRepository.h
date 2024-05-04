#pragma once
#include "Repository.h"
#include <sstream>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

class CSVRepository:public Repository
{
public:
	CSVRepository(const string& filename) : Repository{ filename } {
		this->file = filename;
	}

	//void saveToFile() override;
	//void display() const override;
};

