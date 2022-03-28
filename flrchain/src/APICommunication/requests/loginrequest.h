#ifndef LOGINREQUEST_H
#define LOGINREQUEST_H

#include "apirequest.h"

class LoginRequest : public ApiRequest
{
    Q_OBJECT

public:
    LoginRequest(const QString &email, const QString &password);

signals:
    void loginSuccessful(const QString &token) const;
    void loginError(const QString &error) const;

private:
    void parse() final;
    bool isTokenRequired() const final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;
};

#endif // LOGINREQUEST_H
