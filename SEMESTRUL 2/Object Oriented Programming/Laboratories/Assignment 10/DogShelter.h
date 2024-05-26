#pragma once

#include <QtWidgets/QMainWindow>
#include "ui_DogShelter.h"

class DogShelter : public QMainWindow
{
    Q_OBJECT

public:
    DogShelter(QWidget *parent = nullptr);
    ~DogShelter();

private:
    Ui::DogShelterClass ui;
};
