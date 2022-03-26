#include "milestonemodel.h"
#include "milestone.h"

#include <QDebug>

MilestoneModel::MilestoneModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_milestones()
{

}

QHash<int, QByteArray> MilestoneModel::roleNames() const
{
    static const QHash<int, QByteArray> ROLE_NAMES = {
        { MilestoneIdRole, QByteArrayLiteral("milestoneId") },
        { MilestoneNameRole, QByteArrayLiteral("milestoneName") },
        { MilestoneTasksRole, QByteArrayLiteral("milestoneTasks") }
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
    m_milestones.clear();
    m_milestones = milestones;
    endResetModel();
}
