#include "transactionhistoryrequest.h"

#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include "transaction.h"

TransactionHistoryRequest::TransactionHistoryRequest(const QByteArray &token) : ApiRequest("transactions")
{
    setPriority(Priority::Normal);
    setType(Type::Get);
    setToken(token);
    connect(this, &TransactionHistoryRequest::replyError, this, &TransactionHistoryRequest::errorHandler);
}

void TransactionHistoryRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;
}

void TransactionHistoryRequest::parse()
{
    QJsonObject response(m_replyDocument.object());

    emit walletDataReply(response);
}
