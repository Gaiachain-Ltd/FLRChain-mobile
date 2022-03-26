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
