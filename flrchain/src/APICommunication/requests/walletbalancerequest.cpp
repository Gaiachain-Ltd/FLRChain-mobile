#include "walletbalancerequest.h"

#include <QJsonObject>

WalletBalanceRequest::WalletBalanceRequest(const QByteArray &token)
    : ApiRequest("accounts/balance")
{
    setType(Type::Get);
    setToken(token);
}

void WalletBalanceRequest::parse()
{
    emit walletBalanceReply(m_replyDocument.object().value(QLatin1String("balance")).toDouble());
}
