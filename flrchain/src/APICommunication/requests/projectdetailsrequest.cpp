#include "projectdetailsrequest.h"
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include "project.h"
#include "task.h"

ProjectDetailsRequest::ProjectDetailsRequest(const QByteArray &token, const int projectId) : ApiRequest(QString("projects/%1").arg(projectId))
{
    setPriority(Priority::Normal);
    setType(Type::Get);
    setToken(token);
    connect(this, &ProjectDetailsRequest::replyError, this, &ProjectDetailsRequest::errorHandler);
}

void ProjectDetailsRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;
}

void ProjectDetailsRequest::parse()
{
    QJsonObject projectObject(m_replyDocument.object());

    emit projectDetailsReply(projectObject);
}
