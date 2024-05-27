#include "ShoppingList.h"
#include <QtWidgets/QApplication>
#include "GUI.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    GUI gui;
    gui.show();
    return a.exec();
}
