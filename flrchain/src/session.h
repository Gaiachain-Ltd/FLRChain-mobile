#ifndef SESSION_H
#define SESSION_H

#include <QByteArray>
#include <QObject>
#include <QPointer>
#include "userptr.h"

class RestAPIClient;

class Session : public QObject
{
    Q_OBJECT
    Q_PROPERTY(User* user READ user NOTIFY userChanged)

public:
    explicit Session(QObject *parent = nullptr);
    ~Session();
    void setClient(RestAPIClient *client);
    Q_INVOKABLE bool hasToken() const;
    Q_INVOKABLE void login(const QString& email, const QByteArray& password);
    Q_INVOKABLE void registerUser(const QString& email, const QString& password);
    User* user() const;
    Q_INVOKABLE void setRememberMe(const bool val);
    Q_INVOKABLE bool getRememberMe() const;
    QByteArray getToken() const;
signals:
    void loginSuccessful(const QString& token) const;
    void loginError(const QString& error) const;
    void registrationSuccessful(const QString& apiToken) const;
    void registrationError(const QString& errors) const;
    void userChanged(User* user) const;
    void userInfoError(const QString& error) const;

private:
    void onLoginSuccessful(const QString& token);
    void onRegistrationSuccessful();
    void onUserInfo(const QString& firstName,
                    const QString& lastName,
                    const QString& email);
    void setToken(const QByteArray &token);

    UserPtr mCurrentUser;
    QPointer<RestAPIClient> mClient;
};

#endif // SESSION_H
