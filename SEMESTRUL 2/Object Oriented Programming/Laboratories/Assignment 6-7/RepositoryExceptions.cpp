#include "RepositoryExceptions.h"

FileException::FileException(const string& message) 
{
	this->message = message;
}

const char* FileException::what()
{
	return this->message.c_str();
}

RepositoryException::RepositoryException() : exception()
{
	this->message = "";
}

RepositoryException::RepositoryException(const string& message) 
{
	this->message = message;
}

const char* RepositoryException::what()
{
	return this->message.c_str();  
}

const char* DuplicateDogException::what()
{
	return "The dog is already in the database!";
}

const char* InexistentDogException::what()
{
	return "There are no dogs with the given (to be completed)!";
}
