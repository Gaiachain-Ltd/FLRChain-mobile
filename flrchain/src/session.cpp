#include "session.h"
#include "user.h"
#include "restapiclient.h"
#include "requests/registerrequest.h"
#include "requests/loginrequest.h"

#include <QSharedPointer>
#include <QLoggingCategory>
#include <QDebug>
#include "settings.h"

Q_LOGGING_CATEGORY(session, "core.session")

Session::Session(QObject *parent) : QObject(parent)
{
    mCurrentUser = UserPtr::create();
}

Session::~Session()
{

}

void Session::setClient(RestAPIClient *client)
{
    mClient = client;
}

bool Session::hasToken() const
{
    return !getToken().isEmpty();
}

User* Session::user() const
{
    return mCurrentUser.data();
}

void Session::onLoginSuccessful(const QString &token)
{
    setToken(token.toUtf8());
    emit loginSuccessful(token);
}

void Session::onRegistrationSuccessful()
{

}

void Session::onUserInfo(const QString &firstName, const QString &lastName,
                         const QString &email)
{
    if (!firstName.isEmpty()) user()->setFirstName(firstName);
    if (!lastName.isEmpty()) user()->setLastName(lastName);
    if (!email.isEmpty()) user()->setEmail(email);
}

void Session::login(const QString &email, const QByteArray &password)
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send login request!";
        return;
    }

    auto request = QSharedPointer<LoginRequest>::create(email, password);

    connect(request.data(), &LoginRequest::loginSuccessful,
            this, &Session::onLoginSuccessful);
    connect(request.data(), &LoginRequest::loginError,
            this, &Session::loginError);
    connect(request.data(), &LoginRequest::userInfo,
            this, &Session::onUserInfo);

    mClient->send(request);
}

void Session::registerUser(const QString& email, const QString& password)
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send login request!";
        return;
    }

    auto request = QSharedPointer<RegisterRequest>::create(email, password);
    connect(request.data(), &RegisterRequest::registrationSuccessful,
            this, &Session::onRegistrationSuccessful);
    connect(request.data(), &RegisterRequest::registerError,
            this, &Session::registrationError);
    mClient->send(request);
}

void Session::setRememberMe(const bool val)
{
    Settings::instance()->setValue(Settings::RememberMe, val);
}

bool Session::getRememberMe() const
{
   return Settings::instance()->getValue(Settings::RememberMe).toBool();
}

void Session::setToken(const QByteArray &val)
{
    Settings::instance()->setValue(Settings::Token, val);
}

QByteArray Session::getToken() const
{
   return Settings::instance()->getValue(Settings::Token).toByteArray();
}
