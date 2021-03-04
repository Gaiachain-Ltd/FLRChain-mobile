#ifndef LOGINREQUEST_H
#define LOGINREQUEST_H

#include "apirequest.h"

#include <QString>
#include <QStringList>
#include <QObject>

class LoginRequest : public ApiRequest
{
    Q_OBJECT

public:
    LoginRequest(const QString &email = QString(),
                 const QString &password = QString());
    void errorHandler(const QString& error);
    void onReplyError(const QString& error, QNetworkReply::NetworkError code);

signals:
    void loginSuccessful(const QString &token) const;
    void invalidPassword() const;
    void invalidUsername() const;
    void userInfo(const QString& firstName,
                  const QString& lastName,
                  const QString& email) const;
    void loginError(const QString &msgs) const;
protected:
    virtual void parse() override final;
    virtual bool isTokenRequired() const override final;
};

#include <QSharedPointer>
using LoginRequestPtr = QSharedPointer<LoginRequest>;

#endif // LOGINREQUEST_H
