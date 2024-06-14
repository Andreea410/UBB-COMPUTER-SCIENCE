#include "GUI.h"
#include <QMessageBox>

GUI::GUI(Service& serv, Department d, QWidget* parent) : serv{ serv }, QWidget(parent)
{
	this->serv.addObserver(this);
	this->departament = d;
	QVBoxLayout* mainLayout = new QVBoxLayout;
	this->setWindowTitle(QString::fromStdString(d.getName()));
	this->labelDescription->setText(QString::fromStdString("Description: " + d.getDescription()));

	QFormLayout* formLayout = new QFormLayout;
	formLayout->addRow(labelName, lineEditName);
	formLayout->addRow(labelEmail, lineEditEmail);
	formLayout->addRow(labelInterests, lineEditInterests);



	mainLayout->addWidget(labelDescription);
	mainLayout->addWidget(listDepartament);
	mainLayout->addWidget(listUnassigned);
	mainLayout->addLayout(formLayout);
	mainLayout->addWidget(buttonAdd);
	mainLayout->addWidget(buttonSearch);
	
	this->setLayout(mainLayout);
	connect(this->buttonAdd, &QPushButton::clicked, this, &GUI::addVolunteer);
	connect(this->buttonSearch, &QPushButton::clicked, this ,& GUI::mostSuitable);
	connect(this->listUnassigned, &QListWidget::itemPressed, this ,& GUI::updateDepartament);
	populateList();
	populateUnssigned();

}

void GUI::populateList()
{
	listDepartament->clear();
	vector<Volunteer> volunteers = this->serv.getRepo().getVolunteers();
	for(Volunteer v:volunteers)
	{
		if (v.getDepartament() == this->departament.getName())
		{
			this->listDepartament->addItem(QString::fromStdString(v.toStr()));
		}
	}
}

void GUI::populateUnssigned()
{
	listUnassigned->clear();
	vector<Volunteer> volunteers = this->serv.getRepo().getVolunteers();
	for (Volunteer v : volunteers)
	{
		if (v.getDepartament() == "Unassigned")
		{
			this->listUnassigned->addItem(QString::fromStdString(v.toStr()));
		}
	}
}

void GUI::addVolunteer()
{
	string name = lineEditName->text().toStdString();
	string email = lineEditEmail->text().toStdString();
	string interests = lineEditInterests->text().toStdString();

	try
	{
		this->serv.addVolunteer(Volunteer(name, email, interests, "Unassigned"));
		this->lineEditEmail->clear();
		this->lineEditInterests->clear();
		this->lineEditName->clear();

	}
	catch(exception& e)
	{
		QMessageBox::critical(this, "Error", e.what());
	}

}

void GUI::update()
{
	populateList();
	populateUnssigned();
}

void GUI::mostSuitable()
{
	vector<Volunteer> vs = this->serv.getRepo().mostSuitable(departament);
	listUnassigned->clear();
	for (Volunteer v : vs)
	{
		listUnassigned->addItem(QString::fromStdString(v.toStr()));
	}

}

void GUI::updateDepartament()
{

	auto i = this->listUnassigned->selectedItems();
	if (i.isEmpty())
		return;

	string name = i.at(0)->text().toStdString();

	this->serv.updateDepartament(name, this->departament);

}