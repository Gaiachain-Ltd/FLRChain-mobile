#include "projectsdatarequest.h"

#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include "project.h"
#include "task.h"

ProjectsDataRequest::ProjectsDataRequest(const QByteArray &token) : ApiRequest("projects")
{
    setPriority(Priority::Normal);
    setType(Type::Get);
    setToken(token);
    connect(this, &ProjectsDataRequest::replyError, this, &ProjectsDataRequest::errorHandler);
}

void ProjectsDataRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;
}

void ProjectsDataRequest::parse()
{
    QJsonObject response(m_replyDocument.object());

    emit projectsDataReply(response);
}
