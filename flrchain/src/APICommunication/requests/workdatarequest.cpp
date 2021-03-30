#include "workdatarequest.h"

#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include "work.h"

WorkDataRequest::WorkDataRequest(const QByteArray &token, const int projectId) : ApiRequest(QString("projects/%1/activities").arg(projectId))
{
    setPriority(Priority::Normal);
    setType(Type::Get);
    setToken(token);
    connect(this, &WorkDataRequest::replyError, this, &WorkDataRequest::errorHandler);
}

void WorkDataRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;
}

void WorkDataRequest::parse()
{
    QJsonObject response(m_replyDocument.object());

    emit workDataReply(response);
}
