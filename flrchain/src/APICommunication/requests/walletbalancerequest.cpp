#include "walletbalancerequest.h"

#include <QJsonObject>

WalletBalanceRequest::WalletBalanceRequest(const QByteArray &token) : ApiRequest("accounts/balance")
{
    setPriority(Priority::Normal);
    setType(Type::Get);
    setToken(token);
    connect(this, &WalletBalanceRequest::replyError, this, &WalletBalanceRequest::errorHandler);
}

void WalletBalanceRequest::errorHandler(const QString &error)
{
    qCritical() << "Error" << error;
}

void WalletBalanceRequest::parse()
{
    const QJsonObject object(m_replyDocument.object());
    const double balance(object.value(QLatin1String("balance")).toDouble());

    emit walletBalanceReply(balance);
}
