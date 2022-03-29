#include "projectdetailsrequest.h"

#include <QJsonObject>

ProjectDetailsRequest::ProjectDetailsRequest(const QByteArray &token, const int projectId)
    : ApiRequest(QString("projects/%1").arg(projectId))
{
    setType(Type::Get);
    setToken(token);
}

void ProjectDetailsRequest::parse()
{
    emit projectDetailsReply(m_replyDocument.object());
}
