#include "GUI.h"

GUI::GUI(QWidget* parent) : QWidget(parent)
{
	QVBoxLayout* mainLayout = new QVBoxLayout();
	this->setWindowTitle("TASK MANAGER");

	this->ListAllTasksSorted = new QListWidget;
	this->listPriority = new QListWidget;
	this->addPriority = new QLineEdit;
	this->showPriority = new QPushButton("Show tasks and duration");
	this->totalDuration = new QLabel("Total duration: ");

	mainLayout->addWidget(this->ListAllTasksSorted);
	mainLayout->addWidget(this->addPriority);
	mainLayout->addWidget(this->showPriority);
	mainLayout->addWidget(this->listPriority);
	mainLayout->addWidget(this->totalDuration);

	this->setLayout(mainLayout);

	QObject::connect(this->showPriority, &QPushButton::clicked, this, &GUI::listPrior);
	QObject::connect(this->addPriority, &QLineEdit::textChanged, this, &GUI::listPrior);
	QObject::connect(this->addPriority, &QLineEdit::returnPressed, this, &GUI::listPrior);

	populateList();
}

void GUI::populateList()
{
	vector<Task> tasks = this->service.getRepo().sortTasks();
	for (Task t : tasks)
	{
		QListWidgetItem* item = new QListWidgetItem(t.toStr().c_str());
		if (t.getPriority() == 1)
		{
			QFont font = item->font();
			font.bold();
			item->setFont(font);
		}
		this->ListAllTasksSorted->addItem(item);

	}


}

void GUI::listPrior()
{
	listPriority->clear();
	int priority = this->addPriority->text().toInt();
	int totalDuration = 0;
	vector<Task> tasks = this->service.getRepo().sortTasks();
	for (Task t : tasks)
	{
		QListWidgetItem* item = new QListWidgetItem(t.toStr().c_str());
		if (t.getPriority() == priority)
		{
			this->listPriority->addItem(item);
			totalDuration += t.getDuration();
		}

	}
	this->totalDuration->setText("Total duration: " + QString::number(totalDuration));

}