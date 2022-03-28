#ifndef USERINFOREQUEST_H
#define USERINFOREQUEST_H

#include "apirequest.h"

class UserInfoRequest : public ApiRequest
{
    Q_OBJECT

public:
    UserInfoRequest(const QByteArray &token);

signals:
    void userInfoReply(const QString &firstName,
                       const QString &lastName,
                       const QString &email,
                       const QString &phone,
                       bool optedIn) const;
protected:
    void parse() final;
};

#endif // USERINFOREQUEST_H
