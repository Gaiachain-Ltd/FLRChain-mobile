/*
 * Copyright (C) 2022  Milo Solutions
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

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
