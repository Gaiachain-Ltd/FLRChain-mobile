#ifndef DATATAGMODEL_H
#define DATATAGMODEL_H

#include <QAbstractListModel>

#include "typedefs.h"

class DataTagModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles
    {
        DataTagIdRole = Qt::UserRole,
        DataTagNameRole,
        DataTagTypeRole,
        DataTagUnitRole
    };

    explicit DataTagModel(QObject *parent = nullptr);

    QHash<int, QByteArray> roleNames() const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    void reload(const DataTagList &dataTags);

private:
    DataTagList m_dataTags;
};

Q_DECLARE_METATYPE(DataTagModel*)

#endif // DATATAGMODEL_H
