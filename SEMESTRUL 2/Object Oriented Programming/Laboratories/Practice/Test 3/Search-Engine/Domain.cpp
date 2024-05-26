#include "Domain.h"

Document::Document(string name, string listKeyboard, string content)
{
	this->name = name;
	this->listKeyboard = listKeyboard;
	this->content = content;
}

string Document::getContent()
{
	return this->content;
}

string Document::getListKeyboard()
{
	return this->listKeyboard;
}

string Document::getName()
{
	return this->name;
}

string Document::toStr()
{
	string result = this->getName() + "|" + this->getListKeyboard() + "|" + this->getContent();
	return result;
}