#ifndef RESETPASSWORDREQUEST_H
#define RESETPASSWORDREQUEST_H

#include <apirequest.h>

class ResetPasswordRequest : public ApiRequest
{
    Q_OBJECT

public:
    ResetPasswordRequest(const QString &email);

signals:
    void passwordResetResult(bool success);

private:
    void parse() final;
    bool isTokenRequired() const final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;

};

#endif // RESETPASSWORDREQUEST_H
