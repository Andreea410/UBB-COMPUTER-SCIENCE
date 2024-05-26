#pragma once
#include "Service.h"
#include <QWidget>
#include <QPushButton>
#include <QLabel>
#include <QLineEdit>
#include <QBoxLayout>
#include <QListWidget>

class GUI:public QWidget
{
private:
	Service serv;
	QListWidget* listAll;
	QListWidget* listCategory;
	QListWidget* showNameOrCategory;
	QLineEdit* searchNameOrCategory;
	QLineEdit* search;
	QPushButton* categorySearch;

public:
	GUI(QWidget* parent = Q_NULLPTR);
public slots:
	void populateList();
	void showCatOrName();
	void showCategory();


};

