#include "GUI.h"

GUI::GUI(QWidget* parent) : QWidget(parent)
{
	QVBoxLayout* mainLayout = new QVBoxLayout();
	this->listAllDocuments = new QListWidget;
	this->listSearch = new QListWidget;
	this->listBestMatch = new QListWidget;

	this->lineEditSearch = new QLineEdit;
	this->buttonShowBestMatch = new QPushButton("Show best matching");

	mainLayout->addWidget(this->listAllDocuments);
	mainLayout->addWidget(this->lineEditSearch);
	mainLayout->addWidget(this->listSearch);
	mainLayout->addWidget(this->buttonShowBestMatch);
	mainLayout->addWidget(this->listBestMatch);

	this->setLayout(mainLayout);

	QObject::connect(this->lineEditSearch,&QLineEdit::textChanged,this,&GUI::showSearch);
	QObject::connect(this->buttonShowBestMatch,&QPushButton::clicked,this,&GUI::showBestMatch);

	populateList();

}

void GUI::populateList()
{
	this->listAllDocuments->clear();
	vector<Document> docs = this->serv.getRepo().getDocuments();
	for (Document doc : docs)
		this->listAllDocuments->addItem(QString::fromStdString(doc.toStr()));

}

void GUI::showSearch()
{
	this->listSearch->clear();
	vector<Document> docs = this->serv.getRepo().getDocuments();
	string str = this->lineEditSearch->text().toStdString();
	for (Document doc : docs)
	{
		if (doc.getName().find(str) != std::string::npos || doc.getListKeyboard().find(str) != std::string::npos)
			this->listSearch->addItem(QString::fromStdString(doc.toStr()));
	}
}

void GUI::showBestMatch()
{
	this->listBestMatch->clear();
	string str = this->lineEditSearch->text().toStdString();
	Document doc = this->serv.getBestMatch(str);
	this->listBestMatch->addItem(QString::fromStdString(doc.toStr()));

}