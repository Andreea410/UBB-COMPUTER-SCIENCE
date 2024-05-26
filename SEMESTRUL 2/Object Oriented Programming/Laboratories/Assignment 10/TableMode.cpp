#include <QFont>
#include <QBrush>
#include "TableMode.h"
#include <QPixmap>
#include <QPainter>

TableMode::TableMode(Repository& repository, QObject* parent) : repository{ repository }, QAbstractTableModel{ parent } {
    this->dogsCount = this->repository.getAdoptedDogs().size();
}

TableMode::~TableMode() {

}

int TableMode::rowCount(const QModelIndex& parent) const {
    int dogsNumber = this->repository.getAdoptedDogs().size();
    return dogsNumber;
}

int TableMode::columnCount(const QModelIndex& parent) const {
    return 5;
}

QVariant TableMode::data(const QModelIndex& index, int role) const {
    if (!index.isValid() || index.row() >= dogsCount || index.row() < 0) {
        return QVariant{};
    }

    int row = index.row();
    int column = index.column();

    if (role == Qt::DisplayRole || role == Qt::EditRole) {
        vector<Dog> dogs = this->repository.getAdoptedDogs();
        Dog c = dogs[row];
        switch (column) {
        case 0:
            return QString::fromStdString(c.getBreed());
        case 1:
            return QString::fromStdString(c.getName());
        case 2:
            return QString::fromStdString(to_string(c.getAge()));
        case 3:
            return QString::fromStdString(c.getPhotograph());
        case 4:
            return c.getIsAdopted() ? QString("Yes") : QString("No");
        default:
            break;
        }
    }

    if (role == Qt::FontRole) {
        QFont font("Times", 15, 10, true);
        font.setItalic(false);
        return font;
    }

    return QVariant{};
}


QVariant TableMode::headerData(int section, Qt::Orientation orientation, int role) const {

    if (role == Qt::DisplayRole)
    {
        if (orientation == Qt::Horizontal)
        {
            switch (section) {
            case 0:
                return QString{ "Breed" };

            case 1:
                return QString{ "Name" };

            case 2:
                return QString{ "Age" };

            case 3:
                return QString{ "Photography" };

            case 4:
                return QString{ "Adoption Status" };

            default:
                break;
            }
        }
    }

    if (role == Qt::FontRole)
    {
        QFont font("Times", 15, 10, true);
        font.setBold(true);
        font.setItalic(false);
        return font;
    }

    return QVariant{};
}



Qt::ItemFlags TableMode::flags(const QModelIndex& index) const {
    return Qt::ItemIsSelectable | Qt::ItemIsEditable | Qt::ItemIsEnabled;
}

void TableMode::updateInternalData() {
    this->dogsCount = this->repository.getAdoptedDogs().size();
    beginResetModel();
    endResetModel();
}
