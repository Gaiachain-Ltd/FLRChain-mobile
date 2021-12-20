#include "cashoutrequest.h"
#include <QJsonObject>
#include <QJsonValue>

CashOutRequest::CashOutRequest(const QString& amount, const QString &phone, const QByteArray &token)
    : ApiRequest("payments/mtn/payout")
{
    connect(this, &CashOutRequest::replyError,
            this, &CashOutRequest::errorHandler);

    if (!phone.isEmpty() && amount != 0) {

        QJsonObject object;
        object.insert(QLatin1String("amount"), QJsonValue(amount));
        object.insert(QLatin1String("phone"), QJsonValue(phone));

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
    QJsonObject projectObject(m_replyDocument.object());

    if (projectObject.value("success").toBool()) {
        emit transferReply(true);
    } else {
        emit transferReply(false);
    }
}
