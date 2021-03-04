#include "registerrequest.h"

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

#include <QLoggingCategory>
#include <QDebug>

Q_LOGGING_CATEGORY(requestRegister, "request.register")

RegisterRequest::RegisterRequest(const QString& email, const QString& password)
    : ApiRequest("register")
{
    connect(this, &RegisterRequest::replyError,
            this, &RegisterRequest::errorHandler);

    if (!email.isEmpty() && !password.isEmpty()) {

        QJsonObject object;
        object.insert(QLatin1String("email"), QJsonValue(email));
        object.insert(QLatin1String("password"), QJsonValue(password));

        m_requestDocument.setObject(object);
        m_priority = Priority::High;
        m_type = Type::Post;
    } else {
        qCDebug(requestRegister) << "Error: missing registration info"
                                 << email << password.length();
    }
}

void RegisterRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;

    QString errorMsg;

    if(QString(m_replyData).contains(QLatin1String("user with this email address already exists.")))
    {
        errorMsg = QLatin1String("There is an account registered to this email address. Please enter a different email address");
    }
    else if(QString(m_replyData).contains(QLatin1String("Enter a valid email address."))){
        errorMsg = QLatin1String("Enter a valid email address.");
    }
    else {
        errorMsg = QLatin1String("Registration error");
    }
    emit registerError(errorMsg);
}


void RegisterRequest::parse()
{
    const QJsonObject object(m_replyDocument.object());
    const QString token(object.value(QLatin1String("Token")).toString());

    if (token.isEmpty()) {
        qCDebug(requestRegister) << "Error in parsing server reply"
                                 << m_replyDocument.toJson()
                                 << token;
        emit registerError("Error in parsing server reply");
        return;
    }

    qCDebug(requestRegister) << "Registration successful" << token;
    emit registrationSuccessful(token);
}

bool RegisterRequest::isTokenRequired() const
{
    return false;
}
