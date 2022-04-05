#include "changepasswordrequest.h"

#include <QJsonObject>

ChangePasswordRequest::ChangePasswordRequest(const QString &oldPassword,
                                             const QString &newPassword,
                                             const QByteArray &token)
    : ApiRequest(QLatin1String("change_password"))
{
    QJsonObject object;
    object.insert(QLatin1String("old_password"), oldPassword);
    object.insert(QLatin1String("new_password"), newPassword);

    m_requestDocument.setObject(object);

    setType(Type::Post);
    setToken(token);
}

void ChangePasswordRequest::parse()
{
    const QJsonObject object(m_replyDocument.object());
    emit changePasswordResult(object.value(QLatin1String("status")).toString() == QLatin1String("OK"));
}

void ChangePasswordRequest::handleError(const QString &errorMessage, const QNetworkReply::NetworkError errorCode)
{
    ApiRequest::handleError(errorMessage, errorCode);

    emit changePasswordResult(false);
}
