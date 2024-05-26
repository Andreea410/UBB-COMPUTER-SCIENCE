#include "Repository.h"

void Repository::loadFromFile()
{
	this->documents.clear();
	ifstream inputfile(this->filename);
	if (!inputfile.is_open())
		return;

	string name, listKeyboard, content,line;
	while (getline(inputfile, line))
	{
		istringstream ss(line);
		getline(ss, name, ':');
		getline(ss, listKeyboard, ':');
		getline(ss, content, ':');
		this->documents.push_back(Document(name, listKeyboard, content));
		
	}
	inputfile.close();
}

vector<Document> Repository::getDocuments()
{
	loadFromFile();
	for (int i = 0; i < this->documents.size() - 1; i++)
		for (int j = i; j < this->documents.size(); j++)
			if (documents[i].getName() > documents[j].getName())
				swap(documents[i], documents[j]);
	return this->documents;
}

Document Repository::getBestMatch(string str)
{
	loadFromFile();
	double similarity = -1;
	Document findDoc;
	
	for (Document doc : this->documents)
	{
		double sim = 0;
		if (doc.getName().find(str) != std::string::npos)
			sim += double(str.size()) / double(doc.getName().size());
		if (doc.getContent().find(str) != std::string::npos)
			sim += double(str.size()) /double( doc.getContent().size());
		if (doc.getListKeyboard().find(str) != std::string::npos)
			sim += double(str.size()) / double(doc.getListKeyboard().size());
		if (sim > similarity)
		{
			similarity = sim;
			findDoc = doc;
		}
	}
	return findDoc;
}