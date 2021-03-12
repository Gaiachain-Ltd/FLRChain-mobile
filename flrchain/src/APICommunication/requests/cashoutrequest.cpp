#include "cashoutrequest.h"
#include <QJsonObject>
#include <QJsonValue>

CashOutRequest::CashOutRequest(const double amount, const QString& address, const QByteArray &token)
    : ApiRequest("")
{
    connect(this, &CashOutRequest::replyError,
            this, &CashOutRequest::errorHandler);

    if (!address.isEmpty() && amount != 0) {

        QJsonObject object;
        object.insert(QLatin1String("amount"), QJsonValue(amount));
        object.insert(QLatin1String("address"), QJsonValue(address));

        m_requestDocument.setObject(object);
        setPriority(Priority::High);
        setType(Type::Post);
        setToken(token);
    } else {
        qDebug() << "Error: missing info";
    }
}

void CashOutRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;
    emit transferReply(false);
}

void CashOutRequest::parse()
{
    emit transferReply(true);
}
