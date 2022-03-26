#include "action.h"
#include "milestone.h"

#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>

Action::Action(const int id,
               const QString &name,
               const MilestoneList &milestones,
               QObject *parent)
    : QObject(parent)
    , m_id(id)
    , m_name(name)
    , m_milestones(new MilestoneModel)
{
    reloadMilestones(milestones);
}

int Action::id() const
{
    return m_id;
}

QString Action::name() const
{
    return m_name;
}

void Action::setName(const QString &name)
{
    if (name != m_name) {
        m_name = name;
        emit nameChanged(name);
    }
}

MilestoneModel *Action::milestones() const
{
    return m_milestones.get();
}

void Action::reloadMilestones(const MilestoneList &milestones)
{
    m_milestones->reload(milestones);
}

ActionPtr Action::createFromJson(const QJsonObject &actionObject)
{
    const int actionId = actionObject.value(u"id").toInt();
    const QString actionName = actionObject.value(u"name").toString();

    MilestoneList actionMilestones;
    const QJsonArray milestonesArray = actionObject.value(u"milestones").toArray();

    for (const QJsonValue &value : milestonesArray) {
        const QJsonObject &milestoneObject = value.toObject();
        const MilestonePtr &milestone = Milestone::createFromJson(milestoneObject);
        actionMilestones.append(milestone);
    }

    return ActionPtr::create(actionId, actionName, actionMilestones);
}
