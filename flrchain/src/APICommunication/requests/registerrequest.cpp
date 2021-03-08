#include "registerrequest.h"

#include <QJsonObject>
#include <QJsonValue>

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
        setPriority(Priority::High);
        setType(Type::Post);
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
    emit registrationSuccessful();
}

bool RegisterRequest::isTokenRequired() const
{
    return false;
}
