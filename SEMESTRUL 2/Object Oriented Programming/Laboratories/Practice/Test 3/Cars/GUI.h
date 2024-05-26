#pragma once
#include "Service.h"
#include <QtWidgets/QMainWindow>
#include <QWidget>
#include <QListWidget>
#include <QPushButton>
#include <QLabel>
#include <QLineEdit>
#include <QVBoxLayout>
class GUI : public QWidget
{
private:
	Service service;
	QListWidget* listWidgetAllCars;
	QListWidget* listWidgetFilteredCars;
	QLineEdit* searchByNameLineEdit;
	QPushButton* searchbyNameButton;
	QLabel* numberOfCarsLabel;
public:
	GUI(QWidget* parent = Q_NULLPTR);
	void run();
	void searchByName();
	void populateList();
	public slots:

};

