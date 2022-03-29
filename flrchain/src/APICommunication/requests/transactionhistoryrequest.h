#ifndef TRANSACTIONHISTORYREQUEST_H
#define TRANSACTIONHISTORYREQUEST_H

#include "apirequest.h"

#include <QString>
#include <QObject>

class TransactionHistoryRequest : public ApiRequest
{
    Q_OBJECT

public:
    TransactionHistoryRequest(const QByteArray &token);

signals:
    void walletDataReply(const QJsonObject &response) const;

private:
    void parse() final;
};

#endif // TRANSACTIONHISTORYREQUEST_H
