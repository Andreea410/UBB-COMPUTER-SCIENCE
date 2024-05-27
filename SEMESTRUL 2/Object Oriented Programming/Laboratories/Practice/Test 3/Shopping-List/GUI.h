#include "Service.h"
#include <QWIdget>
#include <QListWidget>
#include <QPushButton>
#include <QLineEdit>
#include <QVBoxLayout>
#include <QLabel>

class GUI : public QWidget
{
private:
	Service service;
	QListWidget* listAllItems;
	QListWidget* listCategory;
	QPushButton* buttonCategory;
	QLineEdit* lineEditCategory;
	QLineEdit* lineEditMatchText;
public:
	GUI(QWidget* parent = Q_NULLPTR);
	void addAllItems();
	void searchItems();
	void searchCategory();

};