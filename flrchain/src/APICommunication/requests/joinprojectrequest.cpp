#include "joinprojectrequest.h"
#include <QJsonObject>
#include <QJsonValue>

JoinProjectRequest::JoinProjectRequest(const int projectId, const QByteArray &token)
    : ApiRequest(QString("projects/%1/assignments").arg(projectId))
    , m_projectId(projectId)
{
    setType(Type::Post);
    setToken(token);
}

void JoinProjectRequest::parse()
{
    emit joinProjectReply(m_projectId);
}

void JoinProjectRequest::handleError(const QString &errorMessage,
                                     const QNetworkReply::NetworkError errorCode)
{
    ApiRequest::handleError(errorMessage, errorCode);

    emit joinProjectError();
}
