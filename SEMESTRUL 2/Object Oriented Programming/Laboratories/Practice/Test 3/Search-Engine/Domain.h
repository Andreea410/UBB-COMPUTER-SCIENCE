#pragma once
#include <string>
#include <string.h>

using namespace std;

class Document
{
private:
	string name;
	string listKeyboard;
	string content;
public:
	Document() {};
	Document(string name, string listKeyboard, string content);
	string getName();
	string getListKeyboard();
	string getContent();
	string toStr();
};

