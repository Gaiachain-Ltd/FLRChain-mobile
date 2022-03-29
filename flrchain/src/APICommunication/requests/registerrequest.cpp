#include "registerrequest.h"

#include <QJsonObject>
#include <QLoggingCategory>

Q_LOGGING_CATEGORY(requestRegister, "request.register")

RegisterRequest::RegisterRequest(const QString &email, const QString &password, const QString &firstName,
                                 const QString &lastName, const QString &phone, const QString &village)
    : ApiRequest("register")
{
    if (!email.isEmpty() && !password.isEmpty()) {
        QJsonObject object;
        object.insert(QLatin1String("email"), QJsonValue(email.toLower()));
        object.insert(QLatin1String("password"), QJsonValue(password));
        object.insert(QLatin1String("first_name"), QJsonValue(firstName));
        object.insert(QLatin1String("last_name"), QJsonValue(lastName));
        object.insert(QLatin1String("phone"), QJsonValue(phone));
        object.insert(QLatin1String("village"), QJsonValue(village));

        m_requestDocument.setObject(object);
        setPriority(Priority::High);
        setType(Type::Post);
    } else {
        qCDebug(requestRegister) << "Error: missing registration info"
                                 << email << password.length();
    }
}

void RegisterRequest::parse()
{
    emit registrationSuccessful();
}

bool RegisterRequest::isTokenRequired() const
{
    return false;
}

void RegisterRequest::handleError(const QString &errorMessage, const QNetworkReply::NetworkError errorCode)
{
    ApiRequest::handleError(errorMessage, errorCode);

    QString message;

    if(QLatin1String(m_replyData).contains(QLatin1String("user with this email address already exists."))) {
        message = tr("There is an account registered to this email address. Please enter a different email address");
    } else if(QLatin1String(m_replyData).contains(QLatin1String("Enter a valid email address."))) {
        message = tr("Enter a valid email address.");
    } else {
        message = tr("Registration error");
    }

    emit registerError(message);
}
