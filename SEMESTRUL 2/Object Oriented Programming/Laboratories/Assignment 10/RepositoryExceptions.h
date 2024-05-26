#pragma once
#include <string>
#include <vector>
#include <exception>


using namespace std;

class FileException : public exception
{
private:
	string message;

public:
	FileException(const string& message);
	virtual const char* what();
};

class RepositoryException : public exception
{
protected:
	string message;

public:
	RepositoryException();
	RepositoryException(const string& message);
	virtual ~RepositoryException() {};
	virtual const char* what();
};

class DuplicateDogException : public RepositoryException
{
public:
	const char* what();
};

class InexistentDogException : public RepositoryException
{
public:
	const char* what();
};

