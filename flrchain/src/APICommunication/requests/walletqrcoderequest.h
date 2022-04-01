#ifndef WALLETQRCODEREQUEST_H
#define WALLETQRCODEREQUEST_H

#include "apirequest.h"

class WalletQRCodeRequest : public ApiRequest
{
    Q_OBJECT

public:
    WalletQRCodeRequest(const QByteArray &token);

signals:
    void walletQRCodeReply(const QString &qrCode) const;

private:
    void parse() final;
};

#endif // WALLETQRCODEREQUEST_H
