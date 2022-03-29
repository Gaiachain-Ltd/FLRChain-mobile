#include "actionmodel.h"
#include "action.h"

#include <QDebug>

ActionModel::ActionModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_actions()
{

}

QHash<int, QByteArray> ActionModel::roleNames() const
{
    static const QHash<int, QByteArray> ROLE_NAMES = {
        { ActionIdRole, QByteArrayLiteral("actionId") },
        { ActionNameRole, QByteArrayLiteral("actionName") },
        { ActionMilestonesRole, QByteArrayLiteral("actionMilestones") }
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
            qWarning() << "Trying to use role that is not editable:" << role;
            break;
    }

    if (modified) {
        emit dataChanged(index, index, {role});
        return true;
    }

    return false;
}

void ActionModel::reload(const ActionList &actions)
{
    beginResetModel();
    m_actions.clear();
    m_actions = actions;
    endResetModel();
}
