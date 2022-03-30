#include "datatagmodel.h"
#include "datatag.h"

#include <QDebug>

DataTagModel::DataTagModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_dataTags()
{
    connect(this, &DataTagModel::rowsInserted, this, &DataTagModel::countChanged);
    connect(this, &DataTagModel::rowsRemoved, this, &DataTagModel::countChanged);
    connect(this, &DataTagModel::modelReset, this, &DataTagModel::countChanged);
}

QHash<int, QByteArray> DataTagModel::roleNames() const
{
    static const QHash<int, QByteArray> ROLE_NAMES = {
        { DataTagIdRole, QByteArrayLiteral("dataTagId") },
        { DataTagNameRole, QByteArrayLiteral("dataTagName") },
        { DataTagTypeRole, QByteArrayLiteral("dataTagType") },
        { DataTagUnitRole, QByteArrayLiteral("dataTagUnit") },
    };

    return ROLE_NAMES;
}

int DataTagModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_dataTags.length();
}

QVariant DataTagModel::data(const QModelIndex &index, int role) const
{
    const int row = index.row();

    if(row < 0 || row >= m_dataTags.length())
        return QVariant();

    const DataTagPtr &dataTag = m_dataTags[row];

    switch (role)
    {
        case DataTagIdRole:
            return dataTag->id();

        case DataTagNameRole:
            return dataTag->name();

        case DataTagTypeRole:
            return static_cast<int>(dataTag->type());

        case DataTagUnitRole:
            return dataTag->unit();
    }

    qWarning() << "Unsupported model role:" << role;

    return QVariant();
}

void DataTagModel::reload(const DataTagList &dataTags)
{
    beginResetModel();
    m_dataTags.clear();
    m_dataTags = dataTags;
    endResetModel();
}
