#include "walletqrcoderequest.h"

WalletQRCodeRequest::WalletQRCodeRequest(const QByteArray &token)
    : ApiRequest("accounts/qrcode")
{
    setType(Type::Get);
    setToken(token);
}

void WalletQRCodeRequest::parse() {
    emit walletQRCodeReply(QString::fromUtf8(m_replyData));
}
