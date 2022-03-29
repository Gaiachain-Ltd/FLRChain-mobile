#include "workdatarequest.h"

#include <QJsonObject>

WorkDataRequest::WorkDataRequest(const QByteArray &token, const int projectId)
    : ApiRequest(QString("projects/%1/activities").arg(projectId))
{
    setType(Type::Get);
    setToken(token);
}

void WorkDataRequest::parse()
{
    emit workDataReply(m_replyDocument.object());
}
