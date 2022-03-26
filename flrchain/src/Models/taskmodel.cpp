#include "taskmodel.h"
#include "task.h"

#include <QDebug>

TaskModel::TaskModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_tasks()
{

}

QHash<int, QByteArray> TaskModel::roleNames() const
{
    static const QHash<int, QByteArray> ROLE_NAMES = {
        { TaskIdRole, QByteArrayLiteral("taskId") },
        { TaskNameRole, QByteArrayLiteral("taskName") },
        { TaskRewardRole, QByteArrayLiteral("taskReward") },
        { TaskBatchRole, QByteArrayLiteral("taskBatch") },
        { TaskFinishedRole, QByteArrayLiteral("taskFinished") },
        { TaskDataTypeTagRole, QByteArrayLiteral("taskDataTypeTag") },
        { TaskProjectIdRole, QByteArrayLiteral("taskProjectId") },
        { TaskDataTagsRole, QByteArrayLiteral("taskDataTags") }
    };

    return ROLE_NAMES;
}

int TaskModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_tasks.length();
}

QVariant TaskModel::data(const QModelIndex &index, int role) const
{
    const int row = index.row();

    if(row < 0 || row >= m_tasks.length())
        return QVariant();

    const TaskPtr &task = m_tasks[row];

    switch (role)
    {
        case TaskIdRole:
            return task->id();

        case TaskNameRole:
            return task->name();

        case TaskRewardRole:
            return task->reward();

        case TaskBatchRole:
            return task->batch();

        case TaskFinishedRole:
            return task->finished();

        case TaskDataTypeTagRole:
            return task->dataTypeTag();

        case TaskProjectIdRole:
            return task->projectId();

        case TaskDataTagsRole:
            return QVariant::fromValue(task->dataTags());
    }

    qWarning() << "Unsupported model role:" << role;

    return QVariant();
}

bool TaskModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    const int row = index.row();

    if(row < 0 || row >= m_tasks.length())
        return false;

    TaskPtr &task = m_tasks[row];
    bool modified = false;

    switch (role)
    {
        case TaskNameRole:
            task->setName(value.toString());
            modified = true;
            break;

        case TaskRewardRole:
            task->setReward(value.toReal());
            modified = true;
            break;

        case TaskBatchRole:
            task->setBatch(value.toReal());
            modified = true;
            break;

        case TaskFinishedRole:
            task->setFinished(value.toBool());
            modified = true;
            break;

        case TaskDataTypeTagRole:
            task->setDataTypeTag(value.toString());
            modified = true;
            break;

        case TaskIdRole:
        case TaskProjectIdRole:
        case TaskDataTagsRole:
            qWarning() << "Trying to use role that is not editable:" << role;
            break;
    }

    if (modified) {
        emit dataChanged(index, index, {role});
        return true;
    }

    return false;
}

void TaskModel::reload(const TaskList &tasks)
{
    beginResetModel();
    m_tasks.clear();
    m_tasks = tasks;
    endResetModel();
}
