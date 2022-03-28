#ifndef WALLETBALANCEREQUEST_H
#define WALLETBALANCEREQUEST_H

#include "apirequest.h"

class WalletBalanceRequest : public ApiRequest
{
    Q_OBJECT

public:
    WalletBalanceRequest(const QByteArray &token);

signals:
    void walletBalanceReply(const double balance) const;

private:
    void parse() final;
};

#endif // WALLETBALANCEREQUEST_H
