#pragma once
#include "Domain.h"
#include <vector>
#include <fstream>
#include <sstream>

class Repository
{
private:
	vector<Document> documents;
	string filename = "documents.txt";
public:
	Repository() {};
	void loadFromFile();
	vector<Document> getDocuments();
	Document getBestMatch(string str);
};

