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

#include "task.h"
#include "datatag.h"
#include "favouritetaskstorage.h"

#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>

Task::Task(const int id,
           const QString &name,
           const qreal reward,
           const qreal batch,
           const bool finished,
           const QString &instructions,
           const QString &dataTypeTag,
           const DataTagList &dataTags,
           const int projectId,
           const QString &projectName,
           const int actionId,
           const QString &actionName,
           const int milestoneId,
           const QString &milestoneName,
           QObject *parent)
    : QObject(parent)
    , m_id(id)
    , m_name(name)
    , m_reward(reward)
    , m_batch(batch)
    , m_finished(finished)
    , m_instructions(instructions)
    , m_dataTypeTag(dataTypeTag)
    , m_dataTags(new DataTagModel)
    , m_projectId(projectId)
    , m_projectName(projectName)
    , m_actionId(actionId)
    , m_actionName(actionName)
    , m_milestoneId(milestoneId)
    , m_milestoneName(milestoneName)
{
    reloadDataTags(dataTags);
}

int Task::id() const
{
    return m_id;
}

QString Task::name() const
{
    return m_name;
}

void Task::setName(const QString &name)
{
    if (name != m_name) {
        m_name = name;
        emit nameChanged(name);
    }
}

qreal Task::reward() const
{
    return m_reward;
}

void Task::setReward(const qreal reward)
{
    if (!qFuzzyCompare(reward, m_reward)) {
        m_reward = reward;
        emit rewardChanged(reward);
    }
}

qreal Task::batch() const
{
    return m_batch;
}

void Task::setBatch(const qreal batch)
{
    if (!qFuzzyCompare(batch, m_batch)) {
        m_batch = batch;
        emit batchChanged(batch);
    }
}

bool Task::finished() const
{
    return m_finished;
}

void Task::setFinished(const bool finished)
{
    if (finished != m_finished) {
        m_finished = finished;
        emit finishedChanged(finished);
    }
}

bool Task::favourite() const
{
    return FavouriteTaskStorage::instance().isTaskFavourite(m_id);
}

void Task::setFavourite(const bool favourite)
{
    if (favourite != Task::favourite()) {
        FavouriteTaskStorage::instance().setTaskFavouriteStatus(m_id, favourite);
        emit favouriteChanged(favourite);
    }
}

QString Task::instructions() const
{
    return m_instructions;
}

void Task::setInstructions(const QString &instructions)
{
    if (instructions != m_instructions) {
        m_instructions = instructions;
        emit instructionsChanged(instructions);
    }
}

QString Task::dataTypeTag() const
{
    return m_dataTypeTag;
}

void Task::setDataTypeTag(const QString &dataTypeTag)
{
    if (dataTypeTag != m_dataTypeTag) {
        m_dataTypeTag = dataTypeTag;
        emit dataTypeTagChanged(dataTypeTag);
    }
}

DataTagModel* Task::dataTags() const
{
    return m_dataTags.get();
}

void Task::reloadDataTags(const DataTagList &dataTags)
{
    m_dataTags->reload(dataTags);
}

int Task::projectId() const
{
    return m_projectId;
}

QString Task::projectName() const
{
    return m_projectName;
}

void Task::setProjectName(const QString &projectName)
{
    if (projectName != m_projectName) {
        m_projectName = projectName;
        emit projectNameChanged(projectName);
    }
}

int Task::actionId() const
{
    return m_actionId;
}

QString Task::actionName() const
{
    return m_actionName;
}

void Task::setActionName(const QString &actionName)
{
    if (actionName != m_actionName) {
        m_actionName = actionName;
        emit actionNameChanged(actionName);
    }
}

int Task::milestoneId() const
{
    return m_milestoneId;
}

QString Task::milestoneName() const
{
    return m_milestoneName;
}

void Task::setMilestoneName(const QString &milestoneName)
{
    if (milestoneName != m_milestoneName) {
        m_milestoneName = milestoneName;
        emit milestoneNameChanged(milestoneName);
    }
}

TaskPtr Task::createFromJson(const QJsonObject &taskObject)
{
    const int taskId = taskObject.value(u"id").toInt();
    const QString taskName = taskObject.value(u"name").toString();
    const qreal taskReward = taskObject.value(u"reward").toDouble();
    const qreal taskBatch = taskObject.value(u"batch").toDouble();
    const bool taskFinished = taskObject.value(u"finished").toBool();
    const QString taskInstructions = taskObject.value(u"instructions").toString();

    const QJsonObject dataTypeTagObject = taskObject.value(u"data_type_tag").toObject();
    const QString taskDataTypeTag = dataTypeTagObject.value(u"name").toString();

    DataTagList taskDataTags;
    const QJsonArray dataTagsArray = taskObject.value(u"data_tags").toArray();

    for (const QJsonValue &value : dataTagsArray) {
        const QJsonObject &dataTagObject = value.toObject();
        const DataTagPtr &dataTag = DataTag::createFromJson(dataTagObject);
        taskDataTags.append(dataTag);
    }

    const int taskProjectId = taskObject.value(u"project_id").toInt();
    const QString taskProjectName = taskObject.value(u"project_name").toString();
    const int taskActionId = taskObject.value(u"action_id").toInt();
    const QString taskActionName = taskObject.value(u"action_name").toString();
    const int taskMilestoneId = taskObject.value(u"milestone_id").toInt();
    const QString taskMilestoneName = taskObject.value(u"milestone_name").toString();

    return TaskPtr::create(taskId,
                           taskName,
                           taskReward,
                           taskBatch,
                           taskFinished,
                           taskInstructions,
                           taskDataTypeTag,
                           taskDataTags,
                           taskProjectId,
                           taskProjectName,
                           taskActionId,
                           taskActionName,
                           taskMilestoneId,
                           taskMilestoneName);
}

TaskPtr Task::emptyTask()
{
    return TaskPtr::create(-1, QString(), 0, 0, false, QString(), QString(),
                           DataTagList(), -1, QString(), -1, QString(), -1, QString());
}
