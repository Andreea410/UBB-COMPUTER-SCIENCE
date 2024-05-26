#include "GUI.h"

GUI::GUI(QWidget* parent) : QWidget(parent)
{
	//this->service = service;
	QVBoxLayout* mainLayout = new QVBoxLayout();
	this->setWindowTitle("Equations");

	this->listWidgetAllEq = new	QListWidget();
	this->listWidgetSol = new QListWidget();

	a = new QLineEdit();
	b = new QLineEdit();
	c = new QLineEdit();

	this->updateEq = new QPushButton("Update equation");
	this->computeEq = new QPushButton("Display solutions");

	mainLayout->addWidget(this->listWidgetAllEq);
	mainLayout->addWidget(a);
	mainLayout->addWidget(b);
	mainLayout->addWidget(c);

	mainLayout->addWidget(this->updateEq);
	mainLayout->addWidget(this->computeEq);
	mainLayout->addWidget(this->listWidgetSol);


	this->setLayout(mainLayout);
	this->populateList();

	QObject::connect(updateEq, &QPushButton::clicked, this, &GUI::updateEquation);
	QObject::connect(listWidgetAllEq, &QListWidget::itemSelectionChanged, this, &GUI::addInput);
	QObject::connect(computeEq, &QPushButton::clicked, this, &GUI::displaySol);
}

void GUI::populateList()
{
	this->listWidgetAllEq->clear();
	vector<Equation> eqs = this->service.getRepo().getEquations();

	for (Equation eq : eqs)
	{
		QListWidgetItem* item = new QListWidgetItem(eq.toStr().c_str());
		this->listWidgetAllEq->addItem(item);
	}
}

void GUI::updateEquation()
{
	double aVal = a->text().toDouble();
	double bVal = b->text().toDouble();
	double cVal = c->text().toDouble();

	this->service.updateEq(index, Equation(aVal, bVal, cVal));
	populateList();
}

void GUI::addInput()
{
	auto eq = listWidgetAllEq->selectedItems();
	if (eq.empty())
		return;

	index = listWidgetAllEq->row(eq[0]);
	
	int i = index;
	Equation equation = this->service.getRepo().getEquations()[i];

	a->setText(QString::number(equation.getA()));
	b->setText(QString::number(equation.getB()));
	c->setText(QString::number(equation.getC()));
}

void GUI::displaySol()
{
	this->listWidgetSol->clear();
	auto index = listWidgetAllEq->selectedItems();

	if (index.empty())
		return;

	int i = listWidgetAllEq->row(index[0]);

	Equation eq = this->service.getRepo().getEquations()[i];
	string sol = eq.solve();

	QListWidgetItem* item = new QListWidgetItem(sol.c_str());
	this->listWidgetSol->addItem(item);
}