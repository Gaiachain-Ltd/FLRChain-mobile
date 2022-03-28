#ifndef SENDWORKREQUEST_H
#define SENDWORKREQUEST_H

#include "apimultipartrequest.h"

class SendWorkRequest : public ApiMultiPartRequest
{
    Q_OBJECT

public:
    SendWorkRequest(const QString &filePath, const int projectId, const int taskId, const QByteArray &token);

signals:
    void workAdded(const QString &taskName, const QString &projectName) const;
    void sendWorkError() const;

private:
    void parse() final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;
};

#endif // SENDWORKREQUEST_H
