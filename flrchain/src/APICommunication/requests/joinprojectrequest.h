#ifndef JOINPROJECTREQUEST_H
#define JOINPROJECTREQUEST_H

#include "apirequest.h"

class JoinProjectRequest: public ApiRequest
{
    Q_OBJECT

public:
    JoinProjectRequest(const int projectId, const QByteArray &token);

signals:
    void joinProjectReply(const int projectId) const;
    void joinProjectError() const;

private:
    void parse() final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;

    int m_projectId;
};

#endif // JOINPROJECTREQUEST_H
