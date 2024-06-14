#pragma once
#include <fstream>
#include <iostream>
#include <sstream>
#include "Volunteer.h"
#include "Department.h"
#include <vector>

using namespace std;
class Repository
{
private:
	vector<Volunteer> volunteers;
	vector<Department> departaments;
	string filenameVolunteers = "volunteers.txt";
	string filenameDepartaments = "departments.txt";
public:
	Repository() {};
	void loadVolunteers()
	{
		volunteers.clear();
		ifstream file(filenameVolunteers);

		string line, name, email, interests, departament;
		while (getline(file, line))
		{
			istringstream ss(line);

			getline(ss, name, ':');
			getline(ss, email, ':');
			getline(ss, interests, ':');
			getline(ss, departament, ':');

			volunteers.push_back(Volunteer(name, email, interests, departament));
		}
		file.close();
	}

	void loadDepartaments()
	{
		departaments.clear();
		ifstream file(filenameDepartaments);

		string line, name, description;
		while (getline(file, line))
		{
			istringstream ss(line);

			getline(ss, name, ':');
			getline(ss, description, ':');
			departaments.push_back(Department(name, description));

		}

	}

	vector<Volunteer> getVolunteers()
	{
		loadVolunteers();
		for(int i = 0;i < volunteers.size() -1;i++)
			for(int j = i+1;j<volunteers.size();j++)
				if (volunteers[i].getName() > volunteers[j].getName())
				{
					swap(volunteers[i], volunteers[j]);
				}
		return this->volunteers;
	}

	vector<Department> getDepartaments()
	{
		loadDepartaments();
		return this->departaments;
	}

	void addVolunteer(Volunteer v)
	{
		loadVolunteers();
		if (v.getName() == "" || v.getEmail() == "")
			throw runtime_error("Tou need to complete the email and name!");
		volunteers.push_back(v);
		saveVolunteers();
	}

	void saveVolunteers()
	{
		ofstream file(this->filenameVolunteers);

		for (Volunteer v : volunteers)
		{
			file << v.getName() << ":" << v.getEmail() << ":" << v.getInterests() << ":" << v.getDepartament() << endl;
		}
		file.close();
	}

	vector<Volunteer> mostSuitable(Department d)
	{
		loadVolunteers();
		Volunteer v1;
		Volunteer v2;
		Volunteer v3;
		double com1 = -1;
		double com2 = -1;
		double com3 = -1;

		vector<string> i;
		for (Volunteer v : volunteers)
		{
			double score;
			if (v.getDepartament() == "Unassigned")
			{
				vector<string> i;
				string interest;
				istringstream ss(v.getInterests());
				while(getline(ss,interest ,',')) {
					i.push_back(interest);
				}
				score = 0;
				for(string s: i)
				{
					vector<string> words;
					string word;
					istringstream ss(s);
					while (getline(ss, word, ' '))
						words.push_back(word);
					for(string w: words)
						if (d.getDescription().find(w) != string::npos)
						{
							score++;
						}
					score = score / (d.getDescription().length());
				}
				if (score > com1)
				{
					v3 = v2;;
					com3 = com2;
					v2 = v1;
					com2 = com1;
					v1 = v;
					com1 = score;
				}
				else if(score > com2)
									{
					v3 = v2;
					com3 = com2;
					v2 = v;
					com2 = score;
				}
				else if (score > com3)
				{
					v3 = v;
					com3 = score;
				}	
			}
				
		}
		vector<Volunteer> vs;
		if(v1.getName() != "")
			vs.push_back(v1);
		if (v2.getName() != "")
			vs.push_back(v2);
		if (v3.getName() != "")
			vs.push_back(v3);
		return vs;

	}

	void updateDepartament(string str , Department d)
	{
		loadVolunteers();
		int i = 0;
		for (Volunteer v : volunteers)
		{
			if (v.toStr() == str)
			{
				v.setDepartament(d.getName());
				volunteers[i].setDepartament(d.getName());
				break;
			}
			i++;
		}
		saveVolunteers();
	}

	int countVolunteers(Department d)
	{
		loadVolunteers();
		int count = 0;
		for (Volunteer v : volunteers)
			if (v.getDepartament() == d.getName())
				count++;
		return count;
	}

	vector<pair<Department, int>> getCountDepartaments()
	{
		loadDepartaments();
		loadVolunteers();
		vector<pair<Department, int>> pairs;
		for (Department d : departaments)
		{
			int count = this->countVolunteers(d);
			pairs.push_back(make_pair(d, count));
		}
		for (int i = 0; i < pairs.size() - 1; i++)
			for (int j = i + 1; j < pairs.size(); j++)
				if (pairs[i].second > pairs[j].second)
					swap(pairs[i], pairs[j]);
		return pairs;
	}

};

