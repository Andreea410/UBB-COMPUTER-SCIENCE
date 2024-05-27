#include "GUI.h"
#include <QMessageBox>

GUI::GUI(QWidget* parent) : QWidget(parent)
{
	QVBoxLayout* mainLayout = new QVBoxLayout;

	this->listAllTasks = new QListWidget;
	this->lineEditPriority = new QLineEdit;
	this->buttonShowPriority = new QPushButton("Show tasks and duration");
	this->listPriority = new QListWidget;
	this-> labelTotalDuration = new QLabel;

	mainLayout->addWidget(listAllTasks);
	mainLayout->addWidget(lineEditPriority);
	mainLayout->addWidget(buttonShowPriority);
	mainLayout->addWidget(listPriority);
	mainLayout->addWidget(labelTotalDuration);

	this->setLayout(mainLayout);
	connect(this->buttonShowPriority, &QPushButton::clicked, this, &GUI::showPriorityAndDuration);
	addAllTasks();


}

void GUI::addAllTasks()
{
	listAllTasks->clear();
	vector<Task> tasks = this->service.getRepo().getTasks();
	for (Task t : tasks)
	{
		QString tDesc = QString::fromStdString(t.toStr());
		QListWidgetItem* item = new  QListWidgetItem(tDesc);
		if (t.getPriority() == 1)
		{
			QFont font = item->font();
			font.setBold(true);
			item->setFont(font);
		}
		listAllTasks->addItem(item);
	}
}

void GUI::showPriorityAndDuration()
{
	listPriority->clear();
	int priority = lineEditPriority->text().toInt();
	vector<Task> tasks = this->service.getRepo().getTasks();
	int totalDuration = 0;	
	int ok = 0;
	for (Task t : tasks)
	{
		if (t.getPriority() == priority)
		{
			ok++;
			totalDuration += t.getDuration();
			QString tDesc = QString::fromStdString(t.toStr());
			QListWidgetItem* item = new  QListWidgetItem(tDesc);
			listPriority->addItem(item);
			
		}
	}

	if (ok == 0)
	{
		QMessageBox::warning(this, "Warning", "No tasks could be found");
		return;
	}
	labelTotalDuration->setText(QString::fromStdString("Total duration: " + to_string(totalDuration)));


}
