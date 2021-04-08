#include "tasksmodel.h"
#include "task.h"

#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

TasksModel::TasksModel(QObject *parent) :
    QAbstractListModel(parent)
{
    m_customNames[TaskId] = "taskId";
    m_customNames[ProjectId] = "projectId";
    m_customNames[Action] = "actionName";
    m_customNames[Reward] = "reward";
}

int TasksModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_items.count();
}

QHash<int, QByteArray> TasksModel::roleNames() const
{
    return m_customNames;
}

QVariant TasksModel::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole && index.row() > m_items.count())
         return QVariant();

    const int row = index.row();

    Task *item = m_items.at(row);

    switch(role) {
    case TaskId:
        return item->taskId();
    case ProjectId:
        return item->projectId();
    case Action:
        return item->action();
    case Reward:
        return item->reward();
    default:
        Q_UNREACHABLE();
        break;
    }

    return QVariant();
}

bool TasksModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(role < Qt::UserRole && index.row() > m_items.count())
         return false;

    const int row = index.row();

    Task *item = m_items.at(row);

    switch(role) {
    case TaskId:
        item->setTaskId(value.toInt());
        break;
    case ProjectId:
        item->setProjectId(value.toInt());
        break;
    case Action:
        item->setAction(value.toString());
        break;
    case Reward:
        item->setReward(value.toDouble());
        break;
    default:
        return false;
    }

    dataChanged(index, index);
    return true;
}

void TasksModel::parseJsonObject(const QJsonObject &response)
{
    clear();
    beginResetModel();
    QJsonArray tasksArray = response.value(QLatin1String("tasks")).toArray();
    const int tasksArraySize = tasksArray.count();

    const int projectId = response.value(QLatin1String("id")).toInt();
    for(int i = 0; i < tasksArraySize; ++i) {
        QJsonObject taskObject = tasksArray.at(i).toObject();
        Task *task = new Task();
        task->setProjectId(projectId);
        task->setTaskId(taskObject.value(QLatin1String("id")).toInt());
        task->setAction(taskObject.value(QLatin1String("action")).toString());
        task->setReward(taskObject.value(QLatin1String("reward")).toString().toDouble());

        m_items.append(task);
    }
    emit tasksReceived();

    endResetModel();
}

void TasksModel::clear()
{
    beginResetModel();
    qDeleteAll(m_items);
    m_items.clear();
    endResetModel();
}
