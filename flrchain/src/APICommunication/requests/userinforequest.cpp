#include "userinforequest.h"

#include <QJsonObject>

UserInfoRequest::UserInfoRequest(const QByteArray &token) : ApiRequest("info")
{
    setPriority(Priority::Normal);
    setType(Type::Get);
    setToken(token);
    connect(this, &UserInfoRequest::replyError, this, &UserInfoRequest::errorHandler);
}

void UserInfoRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;
}

void UserInfoRequest::parse()
{
    const QJsonObject object(m_replyDocument.object());
    qDebug() << "Info:" << object;
    const QString firstName(object.value(QLatin1String("first_name")).toString());
    const QString lastName(object.value(QLatin1String("last_name")).toString());
    const QString email(object.value(QLatin1String("email")).toString());
    const QString phone(object.value(QLatin1String("phone")).toString());
    bool optedIn = object.value(QLatin1String("opted_in")).toBool();

    emit userInfoReply(firstName, lastName, email, phone, optedIn);
}
