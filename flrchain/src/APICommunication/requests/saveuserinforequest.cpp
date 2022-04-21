#include "saveuserinforequest.h"

#include <QJsonObject>

SaveUserInfoRequest::SaveUserInfoRequest(const QString &firstName, const QString &lastName,
                                         const QString &phone, const QString &village,
                                         const QByteArray &token)
    : ApiRequest(QLatin1String("info"))
{
    QJsonObject object;
    object.insert(QLatin1String("first_name"), firstName);
    object.insert(QLatin1String("last_name"), lastName);
    object.insert(QLatin1String("phone"), phone);
    object.insert(QLatin1String("village"), village);

    m_requestDocument.setObject(object);

    setType(Type::Post);
    setToken(token);
}

void SaveUserInfoRequest::parse()
{
    const QJsonObject object(m_replyDocument.object());

    const QString firstName(object.value(QLatin1String("first_name")).toString());
    const QString lastName(object.value(QLatin1String("last_name")).toString());
    const QString email(object.value(QLatin1String("email")).toString());
    const QString phone(object.value(QLatin1String("phone")).toString());
    const QString village(object.value(QLatin1String("village")).toString());
    const bool optedIn = object.value(QLatin1String("opted_in")).toBool();

    emit userInfoReply(firstName, lastName, email, phone, village, optedIn);
    emit saveUserInfoResult(true);
}

void SaveUserInfoRequest::handleError(const QString &errorMessage, const QNetworkReply::NetworkError errorCode)
{
    ApiRequest::handleError(errorMessage, errorCode);

    emit saveUserInfoResult(false);
}
