#include "joinprojectrequest.h"
#include <QJsonObject>
#include <QJsonValue>

JoinProjectRequest::JoinProjectRequest(const int projectId, const QByteArray &token) : ApiRequest(QString("projects/%1/assignments").arg(projectId))
{
    setPriority(Priority::Normal);
    setType(Type::Post);
    setToken(token);
    m_projectId = projectId;
    connect(this, &JoinProjectRequest::replyError, this, &JoinProjectRequest::errorHandler);
}

void JoinProjectRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;
}

void JoinProjectRequest::parse()
{
    emit joinProjectReply(m_projectId);
}
