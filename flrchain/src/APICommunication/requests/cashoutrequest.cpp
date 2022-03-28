#include "cashoutrequest.h"

#include <QJsonObject>

CashOutRequest::CashOutRequest(const QString& amount, const QString &phone, const QByteArray &token)
    : ApiRequest("payments/mtn/payout")
{
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

void CashOutRequest::parse()
{
    emit transferReply(m_replyDocument.object().value("success").toBool());
}

void CashOutRequest::handleError(const QString &errorMessage, const QNetworkReply::NetworkError errorCode)
{
    ApiRequest::handleError(errorMessage, errorCode);

    emit transferReply(false);
}
