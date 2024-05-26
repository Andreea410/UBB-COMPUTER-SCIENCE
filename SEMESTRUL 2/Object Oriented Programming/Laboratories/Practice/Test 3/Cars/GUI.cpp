#include "GUI.h"
#include <QColor>

GUI::GUI(QWidget* parent): QWidget(parent)
{
	QVBoxLayout* mainLayout = new QVBoxLayout();
	this->setWindowTitle("Cars");

	this->listWidgetAllCars = new QListWidget();
	this->listWidgetFilteredCars = new QListWidget();
	this->searchByNameLineEdit = new QLineEdit();
	this->searchbyNameButton = new QPushButton("Search after name");
	this->numberOfCarsLabel = new QLabel("Number of cars: ");

	mainLayout->addWidget(this->listWidgetAllCars);
	mainLayout->addWidget(this->searchByNameLineEdit);
	mainLayout->addWidget(this->searchbyNameButton);
	mainLayout->addWidget(this->listWidgetFilteredCars);
	mainLayout->addWidget(this->numberOfCarsLabel);

	this->setLayout(mainLayout);

	this->populateList();
	QObject::connect(this->searchbyNameButton, &QPushButton::clicked, this, &GUI::searchByName);
	QObject::connect(this->searchByNameLineEdit, &QLineEdit::textChanged, this, &GUI::searchByName);
	QObject::connect(this->searchByNameLineEdit, &QLineEdit::returnPressed, this, &GUI::searchByName);

}

void GUI::searchByName()
{
	string name = this->searchByNameLineEdit->text().toStdString();
	this->listWidgetFilteredCars->clear();
	vector<Car> filteredCars = this->service.filterCarsByName(name);
	for (Car car : filteredCars)
	{
		QString itemInList = QString::fromStdString(car.getName() + "|" + car.getModel() + "|" + to_string(car.getYear()) + "|" + car.getColor());
		this->listWidgetFilteredCars->addItem(itemInList);
	}
	this->numberOfCarsLabel->setText("Number of cars: " + QString::number(filteredCars.size()));
}

void GUI::populateList()
{
	this->listWidgetAllCars->clear();
	vector<Car> cars = this->service.getRepo().getCars();
	for (Car car : cars)
	{
		QString carDescription = QString::fromStdString(car.toString());
		QListWidgetItem* item = new QListWidgetItem(carDescription);

		// Use a fixed color to test
		QColor color("red");
		item->setForeground(color);

		this->listWidgetAllCars->addItem(item);
	}
}

