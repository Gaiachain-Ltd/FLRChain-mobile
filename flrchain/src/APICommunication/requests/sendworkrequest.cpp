#include "sendworkrequest.h"

#include <QJsonObject>

SendWorkRequest::SendWorkRequest(const QString &filePath,
                                 const int projectId,
                                 const int taskId,
                                 const QByteArray &token)
    : ApiMultiPartRequest(QLatin1String("projects/%1/tasks/%2/activities").arg(QString::number(projectId),
                                                                               QString::number(taskId)))
{
    setType(Type::Post);
    setToken(token);

    addPart(QLatin1String("photo"), QFileInfo(filePath));
}

void SendWorkRequest::parse()
{
    const QJsonObject object(m_replyDocument.object());
    const QJsonObject task(object.value(QLatin1String("task")).toObject());
    const QString taskName(task.value(QLatin1String("action")).toString());
    const QJsonObject project(object.value(QLatin1String("project")).toObject());
    const QString projectName(project.value(QLatin1String("title")).toString());

    emit workAdded(taskName, projectName);
}

void SendWorkRequest::handleError(const QString &errorMessage, const QNetworkReply::NetworkError errorCode)
{
    qCritical() << "HTTP response" << errorCode << errorMessage;

    emit sendWorkError();
}
