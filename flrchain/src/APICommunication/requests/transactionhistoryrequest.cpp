#include "transactionhistoryrequest.h"

#include <QJsonObject>

TransactionHistoryRequest::TransactionHistoryRequest(const QByteArray &token)
    : ApiRequest("transactions")
{
    setType(Type::Get);
    setToken(token);
}

void TransactionHistoryRequest::parse()
{
    emit walletDataReply(m_replyDocument.object());
}
