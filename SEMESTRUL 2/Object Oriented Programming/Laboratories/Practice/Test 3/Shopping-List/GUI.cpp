#include "GUI.h"

GUI::GUI(QWidget* parent) : QWidget(parent)
{
	QVBoxLayout* mainLayout = new QVBoxLayout;

	this->listAllItems = new QListWidget;
	this->listCategory = new QListWidget;
	this->buttonCategory = new QPushButton("Show Items");
	this->lineEditCategory = new QLineEdit;
	this->lineEditMatchText = new QLineEdit;

	mainLayout->addWidget(listAllItems);
	mainLayout->addWidget(lineEditMatchText);
	mainLayout->addWidget(lineEditCategory);
	mainLayout->addWidget(buttonCategory);
	mainLayout->addWidget(listCategory);

	this->setLayout(mainLayout);

	QObject::connect(this->lineEditMatchText, &QLineEdit::textChanged, this, &GUI::searchItems);
	QObject::connect(this->buttonCategory, &QPushButton::clicked, this, &GUI::searchCategory);
	addAllItems();


}

void GUI::addAllItems()
{
	this->listAllItems->clear();
	vector<Item> items = this->service.getRepo().getItems();
	for (Item i : items)
	{
		QString itemDesc = QString::fromStdString(i.toStr());
		QListWidgetItem* item = new QListWidgetItem(itemDesc);
		listAllItems->addItem(item);
	}
	

}

void GUI::searchItems()
{
	string str = this->lineEditMatchText->text().toStdString();
	this->listAllItems->clear();
	vector<Item> items = this->service.getRepo().getItems();
	for (Item i : items)
	{
		if (i.getCategory().find(str) != std::string::npos || i.getName().find(str) != std::string::npos)
		{
			QString itemDesc = QString::fromStdString(i.toStr());
			QListWidgetItem* item = new QListWidgetItem(itemDesc);
			listAllItems->addItem(item);
		}
	}
}

void GUI::searchCategory()
{
	string str = this->lineEditCategory->text().toStdString();
	this->listCategory->clear();
	vector<Item> items = this->service.getRepo().getItemsSorted();
	for (Item i : items)
	{
		if (i.getCategory() == str)
		{
			QString itemDesc = QString::fromStdString(i.toStr());
			QListWidgetItem* item = new QListWidgetItem(itemDesc);
			listCategory->addItem(item);
		}
	}
}