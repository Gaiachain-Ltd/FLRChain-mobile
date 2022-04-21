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

#include "taskmodel.h"
#include "task.h"

#include <QDebug>

TaskModel::TaskModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_tasks()
{
    connect(this, &TaskModel::rowsInserted, this, &TaskModel::countChanged);
    connect(this, &TaskModel::rowsRemoved, this, &TaskModel::countChanged);
    connect(this, &TaskModel::modelReset, this, &TaskModel::countChanged);

    connect(this, &TaskModel::countChanged, this, &TaskModel::hasFavouriteTaskChanged);
}

QHash<int, QByteArray> TaskModel::roleNames() const
{
    static const QHash<int, QByteArray> ROLE_NAMES = {
        { TaskIdRole, QByteArrayLiteral("taskId") },
        { TaskNameRole, QByteArrayLiteral("taskName") },
        { TaskRewardRole, QByteArrayLiteral("taskReward") },
        { TaskBatchRole, QByteArrayLiteral("taskBatch") },
        { TaskFinishedRole, QByteArrayLiteral("taskFinished") },
        { TaskFavouriteRole, QByteArrayLiteral("taskFavourite") },
        { TaskInstructionsRole, QByteArrayLiteral("taskInstructions") },
        { TaskTypeOfInformationRole, QByteArrayLiteral("taskTypeOfInformation") },
        { TaskRequiredDataRole, QByteArrayLiteral("taskRequiredData") },
        { TaskProjectIdRole, QByteArrayLiteral("taskProjectId") },
        { TaskProjectNameRole, QByteArrayLiteral("taskProjectName") },
        { TaskActionIdRole, QByteArrayLiteral("taskActionId") },
        { TaskActionNameRole, QByteArrayLiteral("taskActionName") },
        { TaskMilestoneIdRole, QByteArrayLiteral("taskMilestoneId") },
        { TaskMilestoneNameRole, QByteArrayLiteral("taskMilestoneName") }
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

        case TaskFavouriteRole:
            return task->favourite();

        case TaskInstructionsRole:
            return task->instructions();

        case TaskTypeOfInformationRole:
            return task->dataTypeTag();

        case TaskRequiredDataRole:
            return QVariant::fromValue(task->dataTags());

        case TaskProjectIdRole:
            return task->projectId();

        case TaskProjectNameRole:
            return task->projectName();

        case TaskActionIdRole:
            return task->actionId();

        case TaskActionNameRole:
            return task->actionName();

        case TaskMilestoneIdRole:
            return task->milestoneId();

        case TaskMilestoneNameRole:
            return task->milestoneName();
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

        case TaskFavouriteRole:
            task->setFavourite(value.toBool());
            modified = true;
            break;

        case TaskInstructionsRole:
            task->setInstructions(value.toString());
            modified = true;
            break;

        case TaskTypeOfInformationRole:
            task->setDataTypeTag(value.toString());
            modified = true;
            break;

        case TaskProjectNameRole:
            task->setProjectName(value.toString());
            modified = true;
            break;

        case TaskActionNameRole:
            task->setActionName(value.toString());
            modified = true;
            break;

        case TaskMilestoneNameRole:
            task->setMilestoneName(value.toString());
            modified = true;
            break;

        case TaskIdRole:
        case TaskRequiredDataRole:
        case TaskProjectIdRole:
        case TaskActionIdRole:
        case TaskMilestoneIdRole:
            qWarning() << "Trying to use role that is not editable:" << role;
            break;
    }

    if (modified) {
        emit dataChanged(index, index, {role});

        if (role == TaskFavouriteRole) {
            emit hasFavouriteTaskChanged();
        }

        return true;
    }

    return false;
}

void TaskModel::reload(const TaskList &tasks)
{
    beginResetModel();

    for (const TaskPtr &task : qAsConst(m_tasks)) {
        disconnect(task.get(), &Task::favouriteChanged,
                   this, &TaskModel::hasFavouriteTaskChanged);
    }

    m_tasks.clear();
    m_tasks = tasks;

    for (const TaskPtr &task : qAsConst(m_tasks)) {
        connect(task.get(), &Task::favouriteChanged,
                this, &TaskModel::hasFavouriteTaskChanged);
    }

    endResetModel();
}

bool TaskModel::hasFavouriteTask() const
{
    return std::find_if(m_tasks.constBegin(), m_tasks.constEnd(), [&](const TaskPtr& task){
        return task->favourite();
    }) != m_tasks.constEnd();
}
