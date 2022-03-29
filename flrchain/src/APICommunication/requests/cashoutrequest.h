#ifndef CASHOUTREQUEST_H
#define CASHOUTREQUEST_H

#include "apirequest.h"

#include <QObject>

class CashOutRequest : public ApiRequest
{
    Q_OBJECT

public:
    CashOutRequest(const QString& amount, const QString &phone, const QByteArray &token);

signals:
    void transferReply(const bool successful) const;

private:
    void parse() final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;
};

#endif // CASHOUTREQUEST_H
