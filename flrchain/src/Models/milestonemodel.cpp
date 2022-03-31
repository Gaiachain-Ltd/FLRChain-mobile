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

#include "milestonemodel.h"
#include "milestone.h"

#include <QDebug>

MilestoneModel::MilestoneModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_milestones()
{
    connect(this, &MilestoneModel::rowsInserted, this, &MilestoneModel::countChanged);
    connect(this, &MilestoneModel::rowsRemoved, this, &MilestoneModel::countChanged);
    connect(this, &MilestoneModel::modelReset, this, &MilestoneModel::countChanged);

    connect(this, &MilestoneModel::countChanged, this, &MilestoneModel::hasFavouriteTaskChanged);
}

QHash<int, QByteArray> MilestoneModel::roleNames() const
{
    static const QHash<int, QByteArray> ROLE_NAMES = {
        { MilestoneIdRole, QByteArrayLiteral("milestoneId") },
        { MilestoneNameRole, QByteArrayLiteral("milestoneName") },
        { MilestoneTasksRole, QByteArrayLiteral("milestoneTasks") },
        { MilestoneHasFavouriteTaskRole, QByteArrayLiteral("milestoneHasFavouriteTask") }
    };

    return ROLE_NAMES;
}

int MilestoneModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_milestones.length();
}

QVariant MilestoneModel::data(const QModelIndex &index, int role) const
{
    const int row = index.row();

    if(row < 0 || row >= m_milestones.length())
        return QVariant();

    const MilestonePtr &milestone = m_milestones[row];

    switch (role)
    {
        case MilestoneIdRole:
            return milestone->id();

        case MilestoneNameRole:
            return milestone->name();

        case MilestoneTasksRole:
            return QVariant::fromValue(milestone->tasks());

        case MilestoneHasFavouriteTaskRole:
            return milestone->hasFavouriteTask();
    }

    qWarning() << "Unsupported model role:" << role;

    return QVariant();
}

bool MilestoneModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    const int row = index.row();

    if(row < 0 || row >= m_milestones.length())
        return false;

    MilestonePtr &milestone = m_milestones[row];
    bool modified = false;

    switch (role)
    {
        case MilestoneNameRole:
            milestone->setName(value.toString());
            modified = true;
            break;

        case MilestoneIdRole:
        case MilestoneTasksRole:
        case MilestoneHasFavouriteTaskRole:
            qWarning() << "Trying to use role that is not editable:" << role;
            break;
    }

    if (modified) {
        emit dataChanged(index, index, {role});
        return true;
    }

    return false;
}

void MilestoneModel::reload(const MilestoneList &milestones)
{
    beginResetModel();

    for (const MilestonePtr &milestone : qAsConst(m_milestones)) {
        disconnect(milestone.get(), &Milestone::hasFavouriteTaskChanged,
                   this, &MilestoneModel::hasFavouriteTaskChanged);
    }

    m_milestones.clear();
    m_milestones = milestones;

    for (const MilestonePtr &milestone : qAsConst(m_milestones)) {
        connect(milestone.get(), &Milestone::hasFavouriteTaskChanged,
                this, &MilestoneModel::hasFavouriteTaskChanged);
    }

    endResetModel();
}

bool MilestoneModel::hasFavouriteTask() const
{
    return std::find_if(m_milestones.constBegin(), m_milestones.constEnd(), [&](const MilestonePtr &milestone){
        return milestone->hasFavouriteTask();
    }) != m_milestones.constEnd();
}
