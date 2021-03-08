#include "userinforequest.h"

#include <QJsonObject>

UserInfoRequest::UserInfoRequest(const QByteArray &token) : ApiRequest("info")
{
    m_priority = Priority::Normal;
    m_type = Type::Get;
    m_token = token;
    connect(this, &UserInfoRequest::replyError, this, &UserInfoRequest::errorHandler);
}

void UserInfoRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;
}

void UserInfoRequest::parse()
{
    const QJsonObject object(m_replyDocument.object());

    const QString firstName(object.value(QLatin1String("first_name")).toString());
    const QString lastName(object.value(QLatin1String("last_name")).toString());
    const QString email(object.value(QLatin1String("email")).toString());

    emit userInfoReply(firstName, lastName, email);
}
