#pragma once
#include "Repository.h"
#include "Subject.h"
class Service:public Subject
{
private:
	Repository& repo;
public:
	Service() : repo{ repo } {};
	Service(Repository& repo) : repo{ repo } {};
	Repository& getRepo()
	{
		return this->repo;
	}

	void addVolunteer(Volunteer v)
	{
		this->repo.addVolunteer(v);
		notify();
	}

	void updateDepartament(string str , Department departament)
	{
		this->repo.updateDepartament(str, departament);
		notify();
	}

	vector<Department> getDepartaments()
	{
		return this->repo.getDepartaments();
	}

	vector<Volunteer> getVolunteers()
	{
		return this->getVolunteers();
	}

};

