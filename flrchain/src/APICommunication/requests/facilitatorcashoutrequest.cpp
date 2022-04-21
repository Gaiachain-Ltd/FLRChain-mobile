#include "facilitatorcashoutrequest.h"

#include <QJsonObject>

FacilitatorCashOutRequest::FacilitatorCashOutRequest(const QString &amount, int facilitatorId, const QByteArray &token)
    : ApiRequest("payments/facililator")
{
    if (!amount.isEmpty() && facilitatorId > 0) {
        QJsonObject object;
        object.insert(QLatin1String("amount"), QJsonValue(amount));
        object.insert(QLatin1String("id"), QJsonValue(facilitatorId));

        m_requestDocument.setObject(object);
        setPriority(Priority::High);
        setType(Type::Post);
        setToken(token);
    } else {
        qCritical() << "Error: incorrect info";
    }
}

void FacilitatorCashOutRequest::parse()
{
    emit transferReply(m_replyDocument.object().value("success").toBool());
}

void FacilitatorCashOutRequest::handleError(const QString &errorMessage, const QNetworkReply::NetworkError errorCode)
{
    ApiRequest::handleError(errorMessage, errorCode);

    emit transferReply(false);
}
