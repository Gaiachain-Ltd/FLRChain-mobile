#ifndef WALLETCASHOUTREQUEST_H
#define WALLETCASHOUTREQUEST_H

#include "apirequest.h"

#include <QObject>

class WalletCashOutRequest : public ApiRequest
{
    Q_OBJECT

public:
    WalletCashOutRequest(const QString &amount, const QString &address, const QByteArray &token);

signals:
    void transferSuccess(const QString &amount,
                         const QString &address,
                         const QString &transactionId);
    void transferFailed(const QString &errorMessage);

private:
    void parse() final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;

    QString m_amount;
    QString m_address;
};

#endif // WALLETCASHOUTREQUEST_H
