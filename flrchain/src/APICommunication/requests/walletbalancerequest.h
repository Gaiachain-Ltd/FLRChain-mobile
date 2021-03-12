#ifndef WALLETBALANCEREQUEST_H
#define WALLETBALANCEREQUEST_H

#include "apirequest.h"

#include <QString>
#include <QObject>

class WalletBalanceRequest : public ApiRequest
{
    Q_OBJECT

public:
    WalletBalanceRequest(const QByteArray &token);
    void errorHandler(const QString& error);
signals:
    void walletBalanceReply(const double balance) const;
protected:
    virtual void parse() override final;
};

#endif // WALLETBALANCEREQUEST_H
