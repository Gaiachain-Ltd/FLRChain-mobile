#ifndef APIMULTIPARTREQUEST_H
#define APIMULTIPARTREQUEST_H

#include "mmultipartrequest.h"

class ApiMultiPartRequest : public MMultiPartRequest
{
    Q_OBJECT

public:
    explicit ApiMultiPartRequest(const QString &apiEndpoint);

protected:
    void customizeRequest(QNetworkRequest &request) override;
    virtual void handleError(const QString &errorMessage,
                             const QNetworkReply::NetworkError errorCode);
};

#endif // APIMULTIPARTREQUEST_H
