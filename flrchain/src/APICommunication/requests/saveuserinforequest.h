#ifndef SAVEUSERINFOREQUEST_H
#define SAVEUSERINFOREQUEST_H

#include <apirequest.h>

class SaveUserInfoRequest: public ApiRequest
{
    Q_OBJECT

public:
    SaveUserInfoRequest(const QString &firstName,
                        const QString &lastName,
                        const QString &phone,
                        const QString &village,
                        const QByteArray &token);

signals:
    void userInfoReply(const QString &firstName,
                       const QString &lastName,
                       const QString &email,
                       const QString &phone,
                       const QString &village,
                       bool optedIn);
    void saveUserInfoResult(bool success);

private:
    void parse() final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;
};

#endif // SAVEUSERINFOREQUEST_H
