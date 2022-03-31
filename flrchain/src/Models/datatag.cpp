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

#include "datatag.h"

#include <QJsonObject>
#include <QJsonValue>

DataTag::DataTag(const int id,
                 const QString &name,
                 const Type type,
                 const QString &unit,
                 QObject *parent)
    : QObject(parent)
    , m_id(id)
    , m_name(name)
    , m_type(type)
    , m_unit(unit)
{

}

int DataTag::id() const
{
    return m_id;
}

QString DataTag::name() const
{
    return m_name;
}

DataTag::Type DataTag::type() const
{
    return m_type;
}

QString DataTag::unit() const
{
    return m_unit;
}

DataTagPtr DataTag::createFromJson(const QJsonObject &dataTagObject)
{
    const int dataTagId = dataTagObject.value(u"id").toInt();
    const QString dataTagName = dataTagObject.value(u"name").toString();
    const Type dataTagType = static_cast<Type>(dataTagObject.value(u"tag_type").toInt());
    const QString dataTagUnit = dataTagObject.value(u"unit").toString();

    return DataTagPtr::create(dataTagId, dataTagName, dataTagType, dataTagUnit);
}
