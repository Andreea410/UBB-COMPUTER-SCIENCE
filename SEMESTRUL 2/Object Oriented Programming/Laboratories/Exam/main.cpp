#include "EXAM.h"
#include "GUI.h"
#include "Statistics.h"
#include <QtWidgets/QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Repository repo;
    Service serv( repo );

    for (Department d : serv.getRepo().getDepartaments())
    {
       auto gui = new GUI(serv, d);
       gui->show();

    }

    auto statistics = new Statistics(serv);
    statistics->show();

    return a.exec();
    
}
