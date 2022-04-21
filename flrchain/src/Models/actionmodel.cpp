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

#include "actionmodel.h"
#include "action.h"

#include <QDebug>

ActionModel::ActionModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_actions()
{
    connect(this, &ActionModel::rowsInserted, this, &ActionModel::countChanged);
    connect(this, &ActionModel::rowsRemoved, this, &ActionModel::countChanged);
    connect(this, &ActionModel::modelReset, this, &ActionModel::countChanged);

    connect(this, &ActionModel::countChanged, this, &ActionModel::hasFavouriteTaskChanged);
}

QHash<int, QByteArray> ActionModel::roleNames() const
{
    static const QHash<int, QByteArray> ROLE_NAMES = {
        { ActionIdRole, QByteArrayLiteral("actionId") },
        { ActionNameRole, QByteArrayLiteral("actionName") },
        { ActionMilestonesRole, QByteArrayLiteral("actionMilestones") },
        { ActionHasFavouriteTaskRole, QByteArrayLiteral("actionHasFavouriteTask") }
    };

    return ROLE_NAMES;
}

int ActionModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_actions.length();
}

QVariant ActionModel::data(const QModelIndex &index, int role) const
{
    const int row = index.row();

    if(row < 0 || row >= m_actions.length())
        return QVariant();

    const ActionPtr &action = m_actions[row];

    switch (role)
    {
        case ActionIdRole:
            return action->id();

        case ActionNameRole:
            return action->name();

        case ActionMilestonesRole:
            return QVariant::fromValue(action->milestones());

        case ActionHasFavouriteTaskRole:
            return action->hasFavouriteTask();
    }

    qWarning() << "Unsupported model role:" << role;

    return QVariant();
}

bool ActionModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    const int row = index.row();

    if(row < 0 || row >= m_actions.length())
        return false;

    ActionPtr &action = m_actions[row];
    bool modified = false;

    switch (role)
    {
        case ActionNameRole:
            action->setName(value.toString());
            modified = true;
            break;

        case ActionIdRole:
        case ActionMilestonesRole:
        case ActionHasFavouriteTaskRole:
            qWarning() << "Trying to use role that is not editable:" << role;
            break;
    }

    if (modified) {
        emit dataChanged(index, index, {role});
        return true;
    }

    return false;
}

const ActionList &ActionModel::actions() const
{
    return m_actions;
}

void ActionModel::reload(const ActionList &actions)
{
    beginResetModel();

    for (const ActionPtr &action : qAsConst(m_actions)) {
        disconnect(action.get(), &Action::hasFavouriteTaskChanged,
                   this, &ActionModel::hasFavouriteTaskChanged);
    }

    m_actions.clear();
    m_actions = actions;

    for (const ActionPtr &action : qAsConst(m_actions)) {
        connect(action.get(), &Action::hasFavouriteTaskChanged,
                this, &ActionModel::hasFavouriteTaskChanged);
    }

    endResetModel();
}

bool ActionModel::hasFavouriteTask() const
{
    return std::find_if(m_actions.constBegin(), m_actions.constEnd(), [&](const ActionPtr& action){
        return action->hasFavouriteTask();
    }) != m_actions.constEnd();
}
