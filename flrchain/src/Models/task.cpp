#include "task.h"
#include "datatag.h"

#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>

Task::Task(const int id,
           const QString &name,
           const qreal reward,
           const qreal batch,
           const bool finished,
           const bool favourite,
           const QString &dataTypeTag,
           const DataTagList &dataTags,
           QObject *parent)
    : QObject(parent)
    , m_id(id)
    , m_name(name)
    , m_reward(reward)
    , m_batch(batch)
    , m_finished(finished)
    , m_favourite(favourite)
    , m_dataTypeTag(dataTypeTag)
    , m_dataTags(new DataTagModel)
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
    return m_favourite;
}

void Task::setFavourite(const bool favourite)
{
    if (favourite != m_favourite) {
        m_favourite = favourite;
        emit favouriteChanged(favourite);
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

TaskPtr Task::createFromJson(const QJsonObject &taskObject)
{
    const int taskId = taskObject.value(u"id").toInt();
    const QString taskName = taskObject.value(u"name").toString();
    const qreal taskReward = taskObject.value(u"reward").toDouble();
    const qreal taskBatch = taskObject.value(u"batch").toDouble();
    const bool taskFinished = taskObject.value(u"finished").toBool();

    const QJsonObject dataTypeTagObject = taskObject.value(u"data_type_tag").toObject();
    const QString taskDataTypeTag = dataTypeTagObject.value(u"name").toString();

    DataTagList taskDataTags;
    const QJsonArray dataTagsArray = taskObject.value(u"data_tags").toArray();

    for (const QJsonValue &value : dataTagsArray) {
        const QJsonObject &dataTagObject = value.toObject();
        const DataTagPtr &dataTag = DataTag::createFromJson(dataTagObject);
        taskDataTags.append(dataTag);
    }

    return TaskPtr::create(taskId,
                           taskName,
                           taskReward,
                           taskBatch,
                           taskFinished,
                           false,
                           taskDataTypeTag,
                           taskDataTags);
}
