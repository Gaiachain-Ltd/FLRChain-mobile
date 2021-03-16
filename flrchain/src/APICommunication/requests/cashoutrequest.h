#ifndef CASHOUTREQUEST_H
#define CASHOUTREQUEST_H

#include "apirequest.h"

#include <QObject>

class CashOutRequest : public ApiRequest
{
    Q_OBJECT

public:
    CashOutRequest(const double amount, const QString &address, const QByteArray &token);
    void errorHandler(const QString &error);

signals:
    void transferReply(const bool successful) const;

protected:
    virtual void parse() override final;
};

#endif // CASHOUTREQUEST_H
