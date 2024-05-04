#pragma once
#include <string>
#include <iostream>
#include "Service.h"
using namespace std;

class managerUI
{
	
private:
	Service& service;
public:
	managerUI(Service& service) : service(service) {}
	~managerUI();
	bool isNumber(const string& str);
	void displayMenu();
	bool validCommand(int command);
	int readIntegerNumber(const char* message);
	void readString(const char* message, int maxStrSize, char str[]);
	void addAdminUI();
	void removeAdminUI();
	void displayAdminUI();
	void updateAdminUI();
	int runManagerUi();

};