#ifndef USERINFOREQUEST_H
#define USERINFOREQUEST_H

#include "apirequest.h"

#include <QString>
#include <QObject>

class UserInfoRequest : public ApiRequest
{
    Q_OBJECT

public:
    UserInfoRequest(const QByteArray &token);
    void errorHandler(const QString &error);
signals:
    void userInfoReply(const QString &firstName,
                        const QString &lastName,
                        const QString &email) const;
protected:
    virtual void parse() override final;
};

#endif // USERINFOREQUEST_H
