#include "walletcashoutrequest.h"

#include <QJsonObject>

WalletCashOutRequest::WalletCashOutRequest(const QString &amount, const QString &address, const QByteArray &token)
    : ApiRequest("payments/wallet/payout/")
    , m_amount(amount)
    , m_address(address)
{
    if (!address.isEmpty() && amount != 0) {
        QJsonObject object;
        object.insert(QLatin1String("amount"), QJsonValue(amount));
        object.insert(QLatin1String("address"), QJsonValue(address));

        m_requestDocument.setObject(object);
        setPriority(Priority::High);
        setType(Type::Post);
        setToken(token);
    } else {
        qCritical() << "Error: missing info";
    }
}

void WalletCashOutRequest::parse()
{
    const QJsonObject replyObject = m_replyDocument.object();

    if (replyObject.value(u"success").toBool()) {
        emit transferSuccess(m_amount, m_address, replyObject.value(u"txid").toString());
    } else {
        emit transferFailed(tr("Unknown issue occurred."));
    }
}

void WalletCashOutRequest::handleError(const QString &errorMessage, const QNetworkReply::NetworkError errorCode)
{
    ApiRequest::handleError(errorMessage, errorCode);

    emit transferFailed(errorMessage);
}
