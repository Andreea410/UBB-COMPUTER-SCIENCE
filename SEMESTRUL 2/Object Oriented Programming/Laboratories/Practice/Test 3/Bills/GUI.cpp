#include "GUI.h"

GUI::GUI(QWidget* parent) : QWidget(parent)
{
	QVBoxLayout* mainLayout = new QVBoxLayout();
	this->setWindowTitle("Bills");

	this->listAll = new QListWidget;
	this->listSorted = new QListWidget;
	this->buttonSort = new QPushButton("Sort");
	this->buttonCalculateAll = new QPushButton("Calculate total");
	this->lineEditCalculate = new QLineEdit;
	this->lineEditShowTotal = new QLabel("Total of unpaid bills: 0");

	mainLayout->addWidget(this->listAll);
	mainLayout->addWidget(this->buttonSort);
	mainLayout->addWidget(this->listSorted);
	mainLayout->addWidget(this->lineEditCalculate);
	mainLayout->addWidget(this->buttonCalculateAll);
	mainLayout->addWidget(this->lineEditShowTotal);

	this->setLayout(mainLayout);
	QObject::connect(this->buttonCalculateAll, &QPushButton::clicked, this, &GUI::calculateTotal);
	QObject::connect(this->buttonSort, &QPushButton::clicked, this, &GUI::showSorted);
	populateList();

}

void GUI::populateList()
{
	this->listAll->clear();
	vector<Bill> bills = this->serv.getRepo().getBills();
	for (Bill b : bills)
		this->listAll->addItem(QString::fromStdString(b.toStr()));
	
}

void GUI::calculateTotal()
{
	string name = this->lineEditCalculate->text().toStdString();
	double sum = 0;
	sum = this->serv.getTotal(name);
	this->lineEditShowTotal->setText("Total of unpaid bills:" + QString::number(sum));
}

void GUI::showSorted()
{
	this->listSorted->clear();
	vector<Bill> bills = this->serv.getRepo().getSortedBills();
	for (Bill b : bills)
		this->listSorted->addItem(QString::fromStdString(b.toStr()));

}