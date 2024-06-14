#pragma once

#include <QtWidgets/QMainWindow>
#include "ui_EXAM.h"

class EXAM : public QMainWindow
{
    Q_OBJECT

public:
    EXAM(QWidget *parent = nullptr);
    ~EXAM();

private:
    Ui::EXAMClass ui;
};
