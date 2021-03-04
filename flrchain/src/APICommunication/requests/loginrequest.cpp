#include "loginrequest.h"

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

#include <QLoggingCategory>
#include <QDebug>
#include <QList>

Q_LOGGING_CATEGORY(requestLogin, "request.login")

LoginRequest::LoginRequest(const QString &email, const QString &password)
    : ApiRequest("login")
{
    connect(this, &LoginRequest::replyError,
            this, &LoginRequest::errorHandler);

    if (!email.isEmpty() && !password.isEmpty()) {

        QJsonObject object;
        object.insert(QLatin1String("username"), QJsonValue(email));
        object.insert(QLatin1String("password"), QJsonValue(password));

        m_requestDocument.setObject(object);
        m_priority = Priority::High;
        m_type = Type::Post;
        m_email = email;
    } else {
        qCDebug(requestLogin) << "Error: missing login info"
                              << email << password.length();
    }
}

void LoginRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;

    QString errorMsg;

    if(QString(m_replyData).contains(QLatin1String("Unable to log in with provided credentials.")))
    {
        errorMsg = QLatin1String("Unable to log in with provided credentials");
    }
    else {
        errorMsg = QLatin1String("Login error");
    }
    emit loginError(errorMsg);
}

void LoginRequest::parse()
{
    const QJsonObject object(m_replyDocument.object());
    const QString token(object.value(QLatin1String("token")).toString());

    if (token.isEmpty()) {
        qCDebug(requestLogin) << "Error in parsing server reply"
                              << m_replyDocument.toJson()
                              << token;
        emit loginError("Error in parsing server reply");
        return;
    }

    const QString firstName(object.value(QLatin1String("first_name")).toString());
    const QString lastName(object.value(QLatin1String("last_name")).toString());
    const QString email(object.value(QLatin1String("email")).toString());

    emit userInfo(firstName, lastName, m_email);

    qCDebug(requestLogin) << "Login successful" << token.length();
    emit loginSuccessful(token);
}

bool LoginRequest::isTokenRequired() const
{
    return false;
}
