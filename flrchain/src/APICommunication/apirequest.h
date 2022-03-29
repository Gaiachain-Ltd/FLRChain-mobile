#ifndef APIREQUEST_H
#define APIREQUEST_H

#include "mrestrequest.h"

#include <QObject>

class ApiRequest : public MRestRequest
{
    Q_OBJECT

public:
    explicit ApiRequest(const QString &apiEndpoint);

protected:
    void customizeRequest(QNetworkRequest &request) override;
    virtual void handleError(const QString &errorMessage,
                             const QNetworkReply::NetworkError errorCode);
};

#endif // APIREQUEST_H
