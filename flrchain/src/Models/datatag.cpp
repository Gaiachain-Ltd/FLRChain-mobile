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
