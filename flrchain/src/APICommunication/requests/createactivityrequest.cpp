#include "createactivityrequest.h"

#include <QJsonObject>

CreateActivityRequest::CreateActivityRequest(const int projectId,
                                             const int taskId,
                                             const QVariantMap &data,
                                             const QByteArray &token)
    : ApiRequest(QLatin1String("projects/%1/tasks/%2/activities").arg(QString::number(projectId),
                                                                      QString::number(taskId)))
{
    setType(Type::Post);
    setToken(token);
    setDocument(QJsonDocument(QJsonObject::fromVariantMap(data)));
}

void CreateActivityRequest::parse()
{
    emit activityCreated(m_replyDocument.object());
}

void CreateActivityRequest::handleError(const QString &errorMessage,
                                        const QNetworkReply::NetworkError errorCode)
{
    qCritical() << "HTTP response" << errorCode << errorMessage;

    emit activityCreationFailed(errorMessage);
}
