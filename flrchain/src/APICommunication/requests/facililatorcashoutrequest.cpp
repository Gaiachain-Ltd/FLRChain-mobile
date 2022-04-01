#include "facililatorcashoutrequest.h"

#include <QJsonObject>

FacililatorCashOutRequest::FacililatorCashOutRequest(const QString &amount, int facililatorId, const QByteArray &token)
    : ApiRequest("payments/facililator")
{
    if (!amount.isEmpty() && facililatorId > 0) {
        QJsonObject object;
        object.insert(QLatin1String("amount"), QJsonValue(amount));
        object.insert(QLatin1String("id"), QJsonValue(facililatorId));

        m_requestDocument.setObject(object);
        setPriority(Priority::High);
        setType(Type::Post);
        setToken(token);
    } else {
        qDebug() << "Error: incorrect info";
    }
}

void FacililatorCashOutRequest::parse()
{
    emit transferReply(m_replyDocument.object().value("success").toBool());
}

void FacililatorCashOutRequest::handleError(const QString &errorMessage, const QNetworkReply::NetworkError errorCode)
{
    ApiRequest::handleError(errorMessage, errorCode);

    emit transferReply(false);
}
