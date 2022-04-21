#include "resetpasswordrequest.h"

#include <QJsonObject>
#include <QJsonArray>

ResetPasswordRequest::ResetPasswordRequest(const QString &email)
    : ApiRequest(QLatin1String("password_reset"))
{
    QJsonObject object;
    object.insert(QLatin1String("email"), email);

    m_requestDocument.setObject(object);

    setType(Type::Post);
}

void ResetPasswordRequest::parse()
{
    const QJsonObject object(m_replyDocument.object());
    emit passwordResetResult(object.value(QLatin1String("status")).toString() == QLatin1String("OK"));
}

bool ResetPasswordRequest::isTokenRequired() const
{
    return false;
}

void ResetPasswordRequest::handleError(const QString &errorMessage, const QNetworkReply::NetworkError errorCode)
{
    ApiRequest::handleError(errorMessage, errorCode);

    emit passwordResetResult(false, QJsonDocument::fromJson(m_replyData).object().value(u"email").toArray().first().toString());
}
