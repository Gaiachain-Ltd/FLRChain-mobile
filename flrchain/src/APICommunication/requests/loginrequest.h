#ifndef LOGINREQUEST_H
#define LOGINREQUEST_H

#include "apirequest.h"

#include <QString>
#include <QObject>

class LoginRequest : public ApiRequest
{
    Q_OBJECT

public:
    LoginRequest(const QString &email = QString(),
                 const QString &password = QString());
    void errorHandler(const QString& error);

signals:
    void loginSuccessful(const QString &token) const;
    void loginError(const QString &msgs) const;
protected:
    virtual void parse() override final;
    virtual bool isTokenRequired() const override final;
};

#endif // LOGINREQUEST_H
