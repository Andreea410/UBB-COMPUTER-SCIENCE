#pragma once
#include "Service.h"
#include <QWidget>
#include <QLabel>
#include <QPushButton>
#include <QVBoxLayout>
#include <QLineEdit>
#include <QListWidget>

class GUI:public QWidget
{
private:
	Service serv;
	QListWidget* listAllDocuments;
	QListWidget* listSearch;
	QListWidget* listBestMatch;

	QLineEdit* lineEditSearch;
	QPushButton* buttonShowBestMatch;


public:
	GUI(QWidget* parent = Q_NULLPTR);
public slots:
	void populateList();
	void showBestMatch();
	void showSearch();



};

