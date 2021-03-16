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
    void errorHandler(const QString &error);
signals:
    void projectsDataReply(QVariantList walletList) const;
protected:
    virtual void parse() override final;
};

#endif // TRANSACTIONHISTORYREQUEST_H
