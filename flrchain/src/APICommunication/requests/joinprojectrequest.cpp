#include "joinprojectrequest.h"
#include <QJsonObject>
#include <QJsonValue>

JoinProjectRequest::JoinProjectRequest(const int projectId, const QByteArray &token) : ApiRequest("")
{
    QJsonObject object;
    object.insert(QLatin1String("project_id"), QJsonValue(projectId));

    m_requestDocument.setObject(object);
    setPriority(Priority::Normal);
    setType(Type::Post);
    setToken(token);
    connect(this, &JoinProjectRequest::replyError, this, &JoinProjectRequest::errorHandler);
}

void JoinProjectRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;
}

void JoinProjectRequest::parse()
{
    emit joinProjectReply();
}
