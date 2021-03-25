#include "transactionhistoryrequest.h"

#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include "../transaction.h"

TransactionHistoryRequest::TransactionHistoryRequest(const QByteArray &token) : ApiRequest("")
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

    QVariantList walletList;

    QJsonArray walletArray = response.value(QLatin1String("results")).toArray();

    const int arraySize = walletArray.count();
    if(arraySize == 0) {
        qDebug("No resources available");
        return;
    }

    for(int i = 0; i < arraySize; ++i) {
        QJsonObject projectObject = walletArray.at(i).toObject();

        Transaction *transaction = new Transaction();
        transaction->setId(projectObject.value(QLatin1String("id")).toInt());
        transaction->setTitle(projectObject.value(QLatin1String("title")).toString());
        transaction->setType(projectObject.value(QLatin1String("type")).toString());
        transaction->setAmount(projectObject.value(QLatin1String("amount")).toBool());

        walletList.append(QVariant::fromValue(transaction));
    }

    emit walletDataReply(walletList);
}
