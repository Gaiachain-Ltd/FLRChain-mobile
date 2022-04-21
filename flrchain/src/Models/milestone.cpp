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

#include "milestone.h"
#include "task.h"

#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>

Milestone::Milestone(const int id,
                     const QString &name,
                     const TaskList &tasks,
                     QObject *parent)
    : QObject(parent)
    , m_id(id)
    , m_name(name)
    , m_tasks(new TaskModel)
{
    reloadTasks(tasks);

    connect(m_tasks.get(), &TaskModel::hasFavouriteTaskChanged,
            this, &Milestone::hasFavouriteTaskChanged);
}

int Milestone::id() const
{
    return m_id;
}

QString Milestone::name() const
{
    return m_name;
}

void Milestone::setName(const QString &name)
{
    if (name != m_name) {
        m_name = name;
        emit nameChanged(name);
    }
}

TaskModel* Milestone::tasks() const
{
    return m_tasks.get();
}

void Milestone::reloadTasks(const TaskList &tasks)
{
    m_tasks->reload(tasks);
}

bool Milestone::hasFavouriteTask() const
{
    return m_tasks->hasFavouriteTask();
}

MilestonePtr Milestone::createFromJson(const QJsonObject &milestoneObject)
{
    const int milestoneId = milestoneObject.value(u"id").toInt();
    const QString milestoneName = milestoneObject.value(u"name").toString();

    TaskList milestoneTasks;
    const QJsonArray tasksArray = milestoneObject.value(u"tasks").toArray();

    for (const QJsonValue &value : tasksArray) {
        const QJsonObject &taskObject = value.toObject();
        const TaskPtr &task = Task::createFromJson(taskObject);
        milestoneTasks.append(task);
    }

    return MilestonePtr::create(milestoneId, milestoneName, milestoneTasks);
}
