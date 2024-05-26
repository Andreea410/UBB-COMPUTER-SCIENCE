#pragma once
#include "Service.h"
#include <QWidget>
#include <QLabel>
#include <QPushButton>
#include <QListWidget>
#include <QLineEdit>   
#include <QVBoxlayout>
#include <QLabel>


class GUI:public QWidget
{
private:
	Service serv;
	QListWidget* listAll;
	QListWidget* listSorted;
	QPushButton* buttonSort;
	QPushButton* buttonCalculateAll;
	QLineEdit* lineEditCalculate;
	QLabel* lineEditShowTotal;
public:
	GUI(QWidget* parent = Q_NULLPTR);
	void populateList();
	void calculateTotal();
	void showSorted();

};

