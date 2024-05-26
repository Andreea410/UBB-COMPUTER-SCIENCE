#include "Cars.h"
#include "GUI.h"
#include <QtWidgets/QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    GUI gui;
    gui.show();
    return a.exec();
}
