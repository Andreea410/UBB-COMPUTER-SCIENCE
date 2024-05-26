#pragma once
#include <QWidget>
#include <QPushButton>
#include <QListWidget>
#include "Service.h"
#include <qlineedit.h>
#include <QPushButton>
#include <QVBoxLayout>
#include <QLabel>

class GUI:public QWidget
{
private:
	Service service;
	QListWidget* ListAllTasksSorted;
	QListWidget* listPriority;
	QPushButton* showPriority;
	QLineEdit* addPriority;
	QLabel* totalDuration;


public:
	GUI(QWidget* parent = Q_NULLPTR);
public slots:
	void listPrior();
	void populateList();

};

