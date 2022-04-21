#ifndef CHANGEPASSWORDREQUEST_H
#define CHANGEPASSWORDREQUEST_H

#include <apirequest.h>

class ChangePasswordRequest: public ApiRequest
{
    Q_OBJECT

public:
    ChangePasswordRequest(const QString &oldPassword, const QString &newPassword,
                          const QByteArray &token);
signals:
    void changePasswordResult(bool success);

private:
    void parse() final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;
};

#endif // CHANGEPASSWORDREQUEST_H
