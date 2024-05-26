#include "GUI.h"

GUI::GUI(QWidget* parent) : QWidget(parent)
{
	QVBoxLayout* mainLayout = new QVBoxLayout();
	this->setWindowTitle("Items");
	
	this->listAll = new QListWidget();
	this->listCategory = new QListWidget();
	this->showNameOrCategory = new QListWidget();

	this->search = new QLineEdit();
	this->searchNameOrCategory = new QLineEdit();
	this->categorySearch = new QPushButton("Show items");

	mainLayout->addWidget(listAll);
	mainLayout->addWidget(this->searchNameOrCategory);
	mainLayout->addWidget(showNameOrCategory);
	mainLayout->addWidget(search);
	mainLayout->addWidget(categorySearch);
	mainLayout->addWidget(listCategory);

	this->setLayout(mainLayout);
	QObject::connect(this->searchNameOrCategory, &QLineEdit::textChanged, this, &GUI::showCatOrName);
	QObject::connect(this->search, &QLineEdit::textChanged, this, &GUI::showCategory);
	QObject::connect(this->categorySearch, &QPushButton::clicked, this, &GUI::showCategory);



	populateList();

}

void GUI::populateList()
{
	this->listAll->clear();
	vector<Item> items = this->serv.getRepo().getItemsSorted();
	for (Item i : items)
	{
		QListWidgetItem* item = new QListWidgetItem(QString::fromStdString(i.toStr()));
		this->listAll->addItem(item);

	}
}

void GUI::showCatOrName()
{
	this->showNameOrCategory->clear();
	string str = this->searchNameOrCategory->text().toStdString();
	if (str == "")
		return;
	vector<Item> items = this->serv.getRepo().getItems();
	for (Item i : items)
		if(i.getCategory().find(str)!= std::string::npos || i.getName().find(str)!= std::string::npos)
		{
			QListWidgetItem* item = new QListWidgetItem(QString::fromStdString(i.toStr()));
			this->showNameOrCategory->addItem(item);
		}

}

void GUI::showCategory()
{
	this->listCategory->clear();
	string str = this->search->text().toStdString();
	vector<Item> items = this->serv.getRepo().getItems();
	for (Item i : items)
		if (i.getCategory() == str)
		{

			QListWidgetItem* item = new QListWidgetItem(QString::fromStdString(i.toStr()));
			this->listCategory->addItem(item);

		}
}

