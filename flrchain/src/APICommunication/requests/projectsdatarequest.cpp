#include "projectsdatarequest.h"

#include <QJsonObject>

ProjectsDataRequest::ProjectsDataRequest(const QByteArray &token)
    : ApiRequest("projects")
{
    setType(Type::Get);
    setToken(token);
}

void ProjectsDataRequest::parse()
{
    emit projectsDataReply(m_replyDocument.object());
}
