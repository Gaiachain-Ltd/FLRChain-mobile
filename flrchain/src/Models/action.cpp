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

    connect(m_milestones.get(), &MilestoneModel::hasFavouriteTaskChanged,
            this, &Action::hasFavouriteTaskChanged);
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

bool Action::hasFavouriteTask() const
{
    return m_milestones->hasFavouriteTask();
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
