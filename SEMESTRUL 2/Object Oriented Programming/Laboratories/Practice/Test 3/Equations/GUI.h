#pragma once
#include "Service.h"
#include <QListWidget>
#include <QPushButton>
#include <QVBoxLayout>
#include <QLineEdit>

class GUI  :public	QWidget
{
private:
	Service service;
	QListWidget* listWidgetAllEq;  
	QPushButton* updateEq;
	QPushButton* computeEq;
	QListWidget* listWidgetSol;
	QLineEdit* a;
	QLineEdit* b;
	QLineEdit* c;
	int index;

public:
	GUI(QWidget* parent = Q_NULLPTR);
	void populateList();

public slots:
	void updateEquation();
	void addInput();
	void displaySol();
};

