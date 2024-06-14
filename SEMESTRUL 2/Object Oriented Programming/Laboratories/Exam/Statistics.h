#pragma once
#include "GUI.h"

class Statistics : public QWidget , public Observer
{
private:
	Service& serv;
	QListWidget* listAll = new QListWidget;

public:
	Statistics(Service& serv, QWidget* parent = nullptr) : QWidget(parent), serv{serv}
	{
		this->serv.addObserver(this);
		QVBoxLayout* mainLayout = new QVBoxLayout;
		this->setWindowTitle("Statistics");

		mainLayout->addWidget(listAll);

		this->setLayout(mainLayout);

		update();

	}

	void update()
	{
		listAll->clear();
		vector<Department> departaments = this->serv.getRepo().getDepartaments();
		vector<pair<Department, int>> pairs = this->serv.getRepo().getCountDepartaments();
		for (pair<Department, int> p : pairs)
		{
			this->listAll->addItem(QString::fromStdString("Name: " + p.first.getName() +" |  Description: " +p.first.getDescription() + " |  count: " + to_string(p.second)));
		}
	}

};

