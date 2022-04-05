#ifndef FACILILATORCASHOUTREQUEST_H
#define FACILILATORCASHOUTREQUEST_H

#include "apirequest.h"

class FacililatorCashOutRequest : public ApiRequest
{
    Q_OBJECT

public:
    FacililatorCashOutRequest(const QString &amount, int facililatorId, const QByteArray &token);

signals:
    void transferReply(bool successful) const;

private:
    void parse() final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;
};

#endif // FACILILATORCASHOUTREQUEST_H
