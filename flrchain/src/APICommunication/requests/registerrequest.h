#ifndef REGISTERREQUEST_H
#define REGISTERREQUEST_H

#include "apirequest.h"

class RegisterRequest : public ApiRequest
{
    Q_OBJECT

public:
    RegisterRequest(const QString& email, const QString& password, const QString &firstName,
                    const QString &lastName, const QString &phone, const QString &village);

signals:
    void registrationSuccessful() const;
    void registerError(const QString& error);

private:
    void parse() final;
    bool isTokenRequired() const final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;
};

#endif // REGISTERREQUEST_H
