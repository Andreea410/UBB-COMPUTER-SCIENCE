#pragma once
#include "Service.h"
#include "Observer.h"
#include <QWidget>
#include <QListWidget>
#include <QLabel>
#include <QVBoxLayout>
#include <QLineEdit>
#include <QFormLayout>
#include <QPushButton>


class GUI :public QWidget , public Observer
{
private:
	Service& serv;
	Department departament;
	QListWidget* listDepartament = new QListWidget;
	QListWidget* listUnassigned = new QListWidget;
	QLabel* labelDescription = new QLabel("Description");
	QLabel* labelName = new QLabel("Name");
	QLabel* labelEmail = new QLabel("Email");
	QLabel* labelInterests = new QLabel("Interests");


	QLineEdit* lineEditName = new QLineEdit;
	QLineEdit* lineEditEmail = new QLineEdit;
	QLineEdit* lineEditInterests = new QLineEdit;


	QPushButton* buttonAdd = new QPushButton("Add");
	QPushButton* buttonSearch = new QPushButton("Search most compatible");



public:
	GUI(Service& serv, Department departament, QWidget* parent = nullptr);
	void update() override;
	void populateList();
	void populateUnssigned();
	void addVolunteer();
	void mostSuitable();
	void updateDepartament();
};

