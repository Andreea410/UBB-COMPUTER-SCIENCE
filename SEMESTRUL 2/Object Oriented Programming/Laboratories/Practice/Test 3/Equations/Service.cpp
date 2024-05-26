#include "Service.h"

void Service::updateEq(int index, Equation eq)
{
	this->repo.updateEquation(index, eq);
}