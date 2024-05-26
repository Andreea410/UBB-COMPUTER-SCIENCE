#pragma once
#include <QWidget>
#include "dog.h"
#include "service.h"
#include <QApplication>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QPushButton>
#include <QLabel>
#include <QFormLayout>
#include <QLineEdit>
#include <QMessageBox>
#include <QListWidget>
#include <QListWidgetItem>
#include <QObject>
#include <QScrollArea>
#include <string>
#include "TableMode.h"

#include "CSVRepository.h"
#include "HTMLRepository.h"
#include "CustomPlot.h"

using namespace std;

class GUI : public QWidget
{
	Q_OBJECT
private:
	Service service = Service();
	QWidget* window = nullptr;
	QScrollArea* scrollArea = nullptr;
	QTableView* adoptionList;
	TableMode* tableMode;

public:
	GUI(Service service, QWidget* parent = nullptr) :QWidget(parent)
	{
		this->service = service;
	}
	GUI() {};
public slots:
	void login()
	{
		if (window != nullptr)
			window->close();
		window = new QWidget();
		QLabel* label = new QLabel("Please enter the file type (CSV/HTML): ");
		label->setAlignment(Qt::AlignCenter);
		QPushButton* button1 = new QPushButton("CSV");
		QPushButton* button2 = new QPushButton("HTML");
		QPushButton* button3 = new QPushButton("Menu");
		QVBoxLayout* MainLayout = new QVBoxLayout();
		MainLayout->addWidget(label);
		QVBoxLayout* layout = new QVBoxLayout();

		layout->addWidget(button1);
		layout->addWidget(button2);
		layout->addWidget(button3);
		MainLayout->addLayout(layout);

		QObject::connect(button1, &QPushButton::clicked, this, [=]()
			{
				CSVRepository* repo = new CSVRepository("dogs.csv");
				Service service(repo, "dogs.csv");
				this->service = service;
				menu();
			});
		connect(button2, &QPushButton::clicked, this, [=]()
			{
				HTMLRepository* repo = new HTMLRepository("dogs.html");
				Service service(repo, "dogs.html");
				this->service = service;
				menu();
			});

		connect(button3, &QPushButton::clicked, this, &GUI::menu);

		window->setLayout(MainLayout);
		window->show();
	}

	void menu()
	{
		if (window != nullptr)
			window->close();
		window = new QWidget();

		QLabel* label = new QLabel("How would you like to login in today?");
		label->setAlignment(Qt::AlignCenter);

		QPushButton* button1 = new QPushButton("Admin");
		QPushButton* button2 = new QPushButton("User");
		QPushButton* button3 = new QPushButton("Exit");

		QVBoxLayout* MainLayout = new QVBoxLayout();
		MainLayout->addWidget(label);
		QHBoxLayout* layout = new QHBoxLayout();
		layout->addWidget(button1);
		layout->addWidget(button2);
		layout->addWidget(button3);
		MainLayout->addLayout(layout);

		QObject::connect(button1, &QPushButton::clicked, this, &GUI::adminMenu);
		QObject::connect(button2, &QPushButton::clicked, this, &GUI::userMenu);
		QObject::connect(button3, &QPushButton::clicked, this, &GUI::login);

		window->setLayout(MainLayout);
		window->show();
	}

	void adminMenu()
	{
		//window->close();
		if (scrollArea != nullptr)
			scrollArea->close();
		window = new QWidget();

		QLabel* label = new QLabel("Choose an option from above");
		label->setAlignment(Qt::AlignCenter);
		QPushButton* button1 = new QPushButton("Add a new dog");
		QPushButton* button2 = new QPushButton("Remove a dog");
		QPushButton* button3 = new QPushButton("Update a dog");
		QPushButton* button4 = new QPushButton("Display all dogs");
		QPushButton* button5 = new QPushButton("Display the plot");
		QPushButton* button6 = new QPushButton("Undo");
		QPushButton* button7 = new QPushButton("Redo");

		QPushButton* button8 = new QPushButton("Exit");
		QShortcut* undoShortcut = new QShortcut(QKeySequence::Undo, window);
		QShortcut* redoShortcut = new QShortcut(QKeySequence::Redo, window);


		QVBoxLayout* MainLayout = new QVBoxLayout();
		MainLayout->addWidget(label);
		MainLayout->addWidget(button1);
		MainLayout->addWidget(button2);
		MainLayout->addWidget(button3);
		MainLayout->addWidget(button4);
		MainLayout->addWidget(button5);
		MainLayout->addWidget(button6);
		MainLayout->addWidget(button7);
		MainLayout->addWidget(button8);

		connect(button1, &QPushButton::clicked, this, &GUI::optionAdmin1);
		connect(button2, &QPushButton::clicked, this, &GUI::optionAdmin2);
		connect(button3, &QPushButton::clicked, this, &GUI::optionAdmin3);
		connect(button4, &QPushButton::clicked, this, &GUI::optionAdmin4);
		connect(button5, &QPushButton::clicked, this, &GUI::optionAdmin5);
		connect(button6, &QPushButton::clicked, this, &GUI::undo);
		connect(button7, &QPushButton::clicked, this, &GUI::redo);
		connect(button8, &QPushButton::clicked, this, &GUI::menu);
		QObject::connect(undoShortcut, &QShortcut::activated, this, &GUI::undo);
		QObject::connect(redoShortcut, &QShortcut::activated, this, &GUI::redo);

		window->setLayout(MainLayout);
		window->show();
	}

	void optionAdmin1() {
		QWidget* newWindow = new QWidget();

		QLabel* label1 = new QLabel("Name");
		QLabel* label2 = new QLabel("Breed");
		QLabel* label3 = new QLabel("Age");
		QLabel* label4 = new QLabel("Photograph");

		QLineEdit* line1 = new QLineEdit();
		QLineEdit* line2 = new QLineEdit();
		QLineEdit* line3 = new QLineEdit();
		QLineEdit* line4 = new QLineEdit();
		QPushButton* button1 = new QPushButton("Add");
		QPushButton* button2 = new QPushButton("Menu");

		QFormLayout* MainLayout = new QFormLayout();
		QHBoxLayout* layout = new QHBoxLayout();

		MainLayout->addRow(label1, line1);
		MainLayout->addRow(label2, line2);
		MainLayout->addRow(label3, line3);
		MainLayout->addRow(label4, line4);
		layout->addWidget(button1);
		layout->addWidget(button2);

		MainLayout->addRow(layout);

		connect(button1, &QPushButton::clicked, this, [=]() {
			if (line1->text().isEmpty() || line2->text().isEmpty() || line3->text().isEmpty() || line4->text().isEmpty()) {
				QMessageBox::warning(newWindow, "Warning", "All fields must be filled!");
			}
			else {
				string name = line1->text().toStdString();
				string breed = line2->text().toStdString();
				int age = line3->text().toInt();
				string photograph = line4->text().toStdString();
				try {
					Dog d{ breed,name, age, photograph, false };
					this->service.addAdmin(d);
					QMessageBox::information(this, "Success", "Dog added successfully");
					newWindow->close();
					this->adminMenu();
				}
				catch (exception& e) {
					QMessageBox::warning(newWindow, "Error", e.what());
				}
			}
			});

		connect(button2, &QPushButton::clicked, this, &GUI::adminMenu);

		newWindow->setLayout(MainLayout);
		newWindow->show();

		if (window) {
			window->close();
		}
		window = newWindow;
	}

	void optionAdmin2()
	{

		QWidget* newWindow = new QWidget();

		QLabel* label1 = new QLabel("Name");
		QLabel* label2 = new QLabel("Breed");
		QLabel* label3 = new QLabel("Age");

		QLineEdit* line1 = new QLineEdit();
		QLineEdit* line2 = new QLineEdit();
		QLineEdit* line3 = new QLineEdit();

		QPushButton* button1 = new QPushButton("Remove");
		QPushButton* button2 = new QPushButton("Menu");

		QFormLayout* MainLayout = new QFormLayout();
		QHBoxLayout* layout = new QHBoxLayout();

		MainLayout->addRow(label1, line1);
		MainLayout->addRow(label2, line2);
		MainLayout->addRow(label3, line3);
		layout->addWidget(button1);
		layout->addWidget(button2);

		MainLayout->addRow(layout);


		connect(button1, &QPushButton::clicked, this, [=]()
			{
				if (line1->text().isEmpty() || line2->text().isEmpty() || line3->text().isEmpty()) {
					QMessageBox::warning(this, "Warning", "All fields must be filled!");
					return;
				}
				std::string name = line1->text().toStdString();
				std::string breed = line2->text().toStdString();
				int age = line3->text().toInt();
				try
				{
					Dog d{ breed , name , age , "www.jes" , false };
					this->service.removeAdmin(d);
					QMessageBox::information(this, "Success", "Dog removed successfully");
					newWindow->close();
					adminMenu();
				}
				catch (const exception& e)
				{
					QMessageBox::warning(this, "Error", e.what());
				}
				catch (DogExceptions& e)
				{
					QString errorMsg = QString::fromStdString("Validation Errors:\n");
					for (const auto& error : e.getErrors()) {
						errorMsg += QString::fromStdString(error + "\n");
					}
					QMessageBox::warning(newWindow, "Error", errorMsg);
				}
			});

		connect(button2, &QPushButton::clicked, this, &GUI::adminMenu);

		newWindow->setLayout(MainLayout);
		newWindow->show();

		window->close();
		window = newWindow;
	}

	void optionAdmin3()
	{
		QWidget* newWindow = new QWidget();

		QLabel* label1 = new QLabel("Name");
		QLabel* label2 = new QLabel("Breed");
		QLabel* label3 = new QLabel("Age");
		QLabel* label4 = new QLabel("Photograph");

		QLabel* label5 = new QLabel("New Name");
		QLabel* label6 = new QLabel("New Breed");
		QLabel* label7 = new QLabel("New Age");
		QLabel* label8 = new QLabel("New Photograph");

		QLineEdit* line1 = new QLineEdit();
		QLineEdit* line2 = new QLineEdit();
		QLineEdit* line3 = new QLineEdit();
		QLineEdit* line4 = new QLineEdit();

		QLineEdit* line5 = new QLineEdit();
		QLineEdit* line6 = new QLineEdit();
		QLineEdit* line7 = new QLineEdit();
		QLineEdit* line8 = new QLineEdit();

		QPushButton* button1 = new QPushButton("Update");
		QPushButton* button2 = new QPushButton("Menu");

		QFormLayout* MainLayout = new QFormLayout();
		QHBoxLayout* layout = new QHBoxLayout();

		MainLayout->addRow(label1, line1);
		MainLayout->addRow(label2, line2);
		MainLayout->addRow(label3, line3);
		MainLayout->addRow(label4, line4);
		MainLayout->addRow(label5, line5);
		MainLayout->addRow(label6, line6);
		MainLayout->addRow(label7, line7);
		MainLayout->addRow(label8, line8);
		layout->addWidget(button1);
		layout->addWidget(button2);

		MainLayout->addRow(layout);

		connect(button1, &QPushButton::clicked, this, [=]()
			{
				if (line1->text().isEmpty() || line2->text().isEmpty() || line3->text().isEmpty() || line4->text().isEmpty()) {
					QMessageBox::warning(this, "Warning", "All fields must be filled!");
					return;
				}
				std::string name = line1->text().toStdString();
				std::string breed = line2->text().toStdString();
				int age = line3->text().toInt();
				std::string photograph = line4->text().toStdString();

				string new_name = line5->text().toStdString();
				string new_breed = line6->text().toStdString();
				int new_age = line7->text().toInt();
				string new_photograph = line8->text().toStdString();
				try
				{
					Dog d{ breed , name , age , photograph , false };
					Dog d1{ new_breed , new_name , new_age , new_photograph , false };
					this->service.updateAdmin(d, d1);
					QMessageBox::information(this, "Success", "Dog updated successfully");
					newWindow->close();
					adminMenu();
				}
				catch (const exception& e)
				{
					QMessageBox::warning(this, "Error", e.what());
				}
				catch (DogExceptions& e)
				{
					QString errorMsg = QString::fromStdString("Validation Errors:\n");
					for (const auto& error : e.getErrors()) {
						errorMsg += QString::fromStdString(error + "\n");
					}
					QMessageBox::warning(newWindow, "Error", errorMsg);

				}
				catch (RepositoryException& re)
				{
					QMessageBox::warning(newWindow, "Error", re.what());
				}
			});
		connect(button2, &QPushButton::clicked, this, &GUI::adminMenu);

		newWindow->setLayout(MainLayout);
		newWindow->show();

		window->close();
		window = newWindow;
	}


	void optionAdmin4()
	{
		QListWidget* dogList = new QListWidget();

		vector<Dog> dogs = this->service.getRepo()->getDogs();
		for (auto& dog : dogs)
			dogList->addItem(QString::fromStdString(dog.toStr()));


		QFont font("Courier New");
		dogList->setFont(font);
		dogList->setStyleSheet("alternate-background-color: white;background-color: black;");
		dogList->setAlternatingRowColors(true);
		dogList->resize(500, 500);
		dogList->show();

	}

	void optionAdmin5()
	{
		std::map<std::string, int> genreCount = this->service.getMapOfDogsByBreed();

		QCustomPlot* customPlot = new QCustomPlot;

		customPlot->setFixedWidth(800);
		customPlot->setFixedHeight(500);
		customPlot->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);

		QCPBars* genres = new QCPBars(customPlot->xAxis, customPlot->yAxis);

		genres->setAntialiased(false);
		genres->setStackingGap(1);
		genres->setName("Breed");
		// set color to green
		genres->setPen(QPen(QColor(0, 0, 0)));
		genres->setBrush(QColor(17, 140, 54));

		QVector<double> ticks;
		QVector<double> moviesData;
		QVector<QString> labels;
		int positionOfBarChartInTheGraph = 0;
		for (auto& iteratorForBarChart : genreCount) {
			ticks << ++positionOfBarChartInTheGraph;
			labels << QString::fromStdString(iteratorForBarChart.first);
			moviesData << iteratorForBarChart.second;
		}
		QSharedPointer<QCPAxisTickerText> textTicker(new QCPAxisTickerText);


		textTicker->addTicks(ticks, labels);
		genres->setData(ticks, moviesData);

		customPlot->xAxis->setTicker(textTicker);
		customPlot->xAxis->setTickLabelRotation(60);
		customPlot->xAxis->setLabel("Breed");
		customPlot->xAxis->setSubTicks(false);
		customPlot->xAxis->setTickLength(0, 4);
		customPlot->xAxis->setRange(0, 8);
		customPlot->xAxis->grid()->setVisible(true);

		customPlot->yAxis->setRange(0, 12.1);
		customPlot->yAxis->setPadding(5);
		customPlot->yAxis->setLabel("Number of movies");
		customPlot->yAxis->grid()->setPen(QPen(QColor(130, 130, 130), 0, Qt::SolidLine));
		customPlot->yAxis->grid()->setSubGridPen(QPen(QColor(130, 130, 130), 0, Qt::DotLine));

		customPlot->legend->setVisible(true);
		customPlot->axisRect()->insetLayout()->setInsetAlignment(0, Qt::AlignTop | Qt::AlignHCenter);
		customPlot->legend->setBrush(QColor(255, 255, 255, 100));
		customPlot->legend->setBorderPen(Qt::NoPen);

		customPlot->setInteractions(QCP::iRangeDrag | QCP::iRangeZoom);
		customPlot->show();
	}

	void optionAdmin6()
	{
		if(window != nullptr)
			window->close();
		window = new QWidget();
		window->setWindowTitle("Undo/Redo");
		QLabel* label = new QLabel("Choose an option from above");
		label->setAlignment(Qt::AlignCenter);
		QPushButton* button1 = new QPushButton("Undo");
		QPushButton* button2 = new QPushButton("Redo");
		QPushButton* button3 = new QPushButton("Exit");

		QVBoxLayout* MainLayout = new QVBoxLayout();
		MainLayout->addWidget(label);
		MainLayout->addWidget(button1);
		MainLayout->addWidget(button2);
		MainLayout->addWidget(button3);
		

		connect(button3, &QPushButton::clicked, this, &GUI::adminMenu);

		window->setLayout(MainLayout);
		window->show();

	}

	void undo() {
		try
		{
			int res = this->service.undoAdminMode();
			if (res == 1)
			{
				QMessageBox::critical(this, "Error", "There are no more undos");
				return;
			}
		}
		catch (exception& e) 
		{
			QMessageBox::critical(this, "Error", e.what());
		}
		catch (RepositoryException& re)
		{
			QMessageBox::critical(this, "Error", re.what());
		}
		catch (DogExceptions& e)
		{
			QString errorMsg = QString::fromStdString("Validation Errors:\n");
			for (const auto& error : e.getErrors()) {
				errorMsg += QString::fromStdString(error + "\n");
			}
			QMessageBox::warning(this, "Error", errorMsg);
		}

	}

	void redo() {
		try {
			int res = this->service.redoAdminMode();
			if (res == 1)
			{
				QMessageBox::critical(this, "Error", "There are no more redos");
				return;
			}
		}
		catch (exception& e)
		{
			QMessageBox::critical(this, "Error", e.what());
		}
		catch (DogExceptions& e)
		{
			QString errorMsg = QString::fromStdString("Validation Errors:\n");
			for (const auto& error : e.getErrors()) {
				errorMsg += QString::fromStdString(error + "\n");
			}
			QMessageBox::warning(this, "Error", errorMsg);

		}
	}

	void userMenu()
	{
		if (window != nullptr)
			window->close();
		if (scrollArea != nullptr)
			scrollArea->close();
		window = new QWidget();

		QLabel* label = new QLabel("Choose an option from above");
		label->setAlignment(Qt::AlignCenter);
		QPushButton* button1 = new QPushButton("Display all dogs");
		QPushButton* button2 = new QPushButton("Display dogs of given breed");
		QPushButton* button3 = new QPushButton("See the adoption list");
		QPushButton* button4 = new QPushButton("Open external");
		QPushButton* button5 = new QPushButton("Open table view");
		QPushButton* button6 = new QPushButton("Exit");


		QVBoxLayout* MainLayout = new QVBoxLayout();
		MainLayout->addWidget(label);
		MainLayout->addWidget(button1);
		MainLayout->addWidget(button2);
		MainLayout->addWidget(button3);
		MainLayout->addWidget(button4);
		MainLayout->addWidget(button5);
		MainLayout->addWidget(button6);

		connect(button1, &QPushButton::clicked, this, &GUI::optionUser1);
		connect(button2, &QPushButton::clicked, this, &GUI::optionUser2);
		connect(button3, &QPushButton::clicked, this, &GUI::optionUser3);
		connect(button4, &QPushButton::clicked, this, &GUI::optionUser4);
		connect(button5, &QPushButton::clicked, this, &GUI::optionUser5);
		connect(button6, &QPushButton::clicked, this, &GUI::menu);

		window->setLayout(MainLayout);
		window->show();
	}

	void optionUser1() {
		vector<Dog> dogs = this->service.getRepo()->getDogs();

		for (auto& dog : dogs) {
			QWidget* window = new QWidget();

			QListWidget* dogList = new QListWidget();
			dogList->addItem(QString::fromStdString(dog.toStr()));

			QLabel* label = new QLabel("Choose an option from above");
			label->setAlignment(Qt::AlignCenter);
			QPushButton* button1 = new QPushButton("Adopt");
			QPushButton* button2 = new QPushButton("Don't adopt");
			QPushButton* button3 = new QPushButton("Exit");

			QVBoxLayout* MainLayout = new QVBoxLayout();
			MainLayout->addWidget(label);
			MainLayout->addWidget(dogList);
			MainLayout->addWidget(button1);
			MainLayout->addWidget(button2);
			MainLayout->addWidget(button3);

			connect(button1, &QPushButton::clicked, window, [=]() {
				try {
					this->service.addUser(dog);
					QMessageBox::information(window, "Success", "Dog adopted successfully");
					window->close();
					userMenu();
				}
				catch (exception& e) {
					QMessageBox::warning(window, "Error", e.what());
				}
				catch (DogExceptions& e) {
					QString errorMsg = QString::fromStdString("Validation Errors:\n");
					for (const auto& error : e.getErrors()) {
						errorMsg += QString::fromStdString(error + "\n");
					}
					QMessageBox::warning(window, "Error", errorMsg);
				}
				});

			connect(button2, &QPushButton::clicked, window, [=]() {
				window->close();
				});

			connect(button3, &QPushButton::clicked, window, [=]() {
				window->close();
				userMenu();
				});

			window->setLayout(MainLayout);
			window->show();
		}
	}

	void optionUser3()
	{
		QListWidget* dogList = new QListWidget();

		vector<Dog> dogs = this->service.getRepo()->getDogs();
		for (auto& dog : dogs)
			if (dog.getIsAdopted())
				dogList->addItem(QString::fromStdString(dog.toStr()));


		QFont font("Courier New");
		dogList->setFont(font);
		dogList->setStyleSheet("alternate-background-color: white;background-color: black;");
		dogList->setAlternatingRowColors(true);
		dogList->resize(500, 500);
		dogList->show();;

	}


	void optionUser2() {
		if (window != nullptr)
			window->close();
		QWidget* searchWindow = new QWidget();

		QLabel* label2 = new QLabel("Breed");
		QLineEdit* line2 = new QLineEdit();
		QPushButton* button1 = new QPushButton("Search");


		QFormLayout* MainLayout = new QFormLayout();
		QHBoxLayout* layout = new QHBoxLayout();


		MainLayout->addRow(label2, line2);
		layout->addWidget(button1);
		MainLayout->addRow(layout);


		connect(button1, &QPushButton::clicked, this, [=]() {
			if (line2->text().isEmpty()) {
				QMessageBox::warning(searchWindow, "Warning", "All fields must be filled!");
				return;
			}
			string breed = line2->text().toStdString();
			search_breed(breed, searchWindow);
			});


		searchWindow->setLayout(MainLayout);
		searchWindow->show();
	}

	void search_breed(const string& breed, QWidget* parentWindow) {
		vector<Dog> dogs = this->service.getRepo()->getDogs();
		parentWindow->close();

		bool found = false;

		for (auto& dog : dogs) {
			if (dog.getBreed() == breed) {
				found = true;

				QWidget* dogWindow = new QWidget();

				QListWidget* dogList = new QListWidget();
				dogList->addItem(QString::fromStdString(dog.toStr()));

				QLabel* label = new QLabel("Choose an option from above");
				label->setAlignment(Qt::AlignCenter);
				QPushButton* button1 = new QPushButton("Adopt");
				QPushButton* button2 = new QPushButton("Don't adopt");
				QPushButton* button3 = new QPushButton("Exit");

				QVBoxLayout* MainLayout = new QVBoxLayout();
				MainLayout->addWidget(label);
				MainLayout->addWidget(dogList);
				MainLayout->addWidget(button1);
				MainLayout->addWidget(button2);
				MainLayout->addWidget(button3);

				connect(button1, &QPushButton::clicked, dogWindow, [=, &dog]() {
					try {
						this->service.addUser(dog);
						QMessageBox::information(dogWindow, "Success", "Dog adopted successfully");
						dogWindow->close();
						userMenu();
					}
					catch (exception& e) {
						QMessageBox::warning(dogWindow, "Error", e.what());
					}
					catch (DogExceptions& e) {
						QString errorMsg = QString::fromStdString("Validation Errors:\n");
						for (const auto& error : e.getErrors()) {
							errorMsg += QString::fromStdString(error + "\n");
						}
						QMessageBox::warning(dogWindow, "Error", errorMsg);
					}
					});

				connect(button2, &QPushButton::clicked, dogWindow, [=]() {
					dogWindow->close();
					});

				connect(button3, &QPushButton::clicked, dogWindow, [=]() {
					dogWindow->close();
					userMenu();
					});

				dogWindow->setLayout(MainLayout);
				dogWindow->show();
			}
		}

		if (!found) {
			QMessageBox::information(parentWindow, "Info", "No dogs of the specified breed found.");
		}
	}

	void optionUser4()
	{
		if(window!=nullptr)
			window->close();
		this->service.getRepo()->open();
	}

	void optionUser5()
	{
		try {
			this->tableMode = new TableMode{ *this->service.getRepo() };
			this->adoptionList = new QTableView{};
			this->adoptionList->setModel(this->tableMode);
			this->adoptionList->resize(1200, 800);
			this->adoptionList->resizeColumnsToContents();
			this->adoptionList->resizeRowsToContents();
			this->adoptionList->staticMetaObject.connectSlotsByName(this->adoptionList);
			this->adoptionList->show();
		}
		catch (const std::exception& ex) {
			qCritical() << "Exception occurred: " << ex.what();
		}
		catch (...) {
			qCritical() << "Unknown exception occurred.";
		}
	}



};