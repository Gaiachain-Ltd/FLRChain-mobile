#ifndef CREATEACTIVITYREQUEST_H
#define CREATEACTIVITYREQUEST_H

#include "apirequest.h"

class CreateActivityRequest : public ApiRequest
{
    Q_OBJECT

public:
    CreateActivityRequest(const int projectId,
                          const int taskId,
                          const QVariantMap &data,
                          const QByteArray &token);

signals:
    void activityCreated(const QJsonObject &data);
    void activityCreationFailed(const QString &errorMessage);

private:
    void parse() final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;
};

#endif // CREATEACTIVITYREQUEST_H
