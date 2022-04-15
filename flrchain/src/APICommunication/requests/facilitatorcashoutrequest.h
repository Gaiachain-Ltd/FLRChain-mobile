#ifndef FACILITATORCASHOUTREQUEST_H
#define FACILITATORCASHOUTREQUEST_H

#include "apirequest.h"

class FacilitatorCashOutRequest : public ApiRequest
{
    Q_OBJECT

public:
    FacilitatorCashOutRequest(const QString &amount, int facilitatorId, const QByteArray &token);

signals:
    void transferReply(bool successful) const;

private:
    void parse() final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;
};

#endif // FACILITATORCASHOUTREQUEST_H
