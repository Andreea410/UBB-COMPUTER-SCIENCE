#include "Service.h"
#include <QListWidget>
#include <QWidget>
#include <QPushButton>
#include <QVBoxLayout>
#include <QLineEdit>
#include <QLabel>

class GUI:public QWidget
{
private:
	Service service;
	QListWidget* listAllTasks;
	QLineEdit* lineEditPriority;
	QPushButton* buttonShowPriority;
	QListWidget* listPriority;
	QLabel* labelTotalDuration;
public:
	GUI(QWidget* parent = Q_NULLPTR);
	void addAllTasks();
	void showPriorityAndDuration();

};