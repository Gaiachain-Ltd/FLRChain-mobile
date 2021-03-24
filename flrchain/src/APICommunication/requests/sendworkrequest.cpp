#include "sendworkrequest.h"
#include <QJsonObject>
#include <QJsonValue>

SendWorkRequest::SendWorkRequest(const QString &filePath, const int projectId, const int taskId, const QByteArray &token)
 : MMultiPartRequest(QUrl())
{
    setToken(token);
    setAddress(QUrl(APIUrl + QString("projects/%1/tasks/%2/activities/").arg(projectId).arg(taskId)));
    setPriority(Priority::Normal);
    setType(Type::Post);

    addPart(QLatin1String("photo"), QFileInfo(filePath));

    connect(this, &SendWorkRequest::replyError, this, &SendWorkRequest::errorHandler);
}

void SendWorkRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;
    emit sendWorkError();
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

void SendWorkRequest::customizeRequest(QNetworkRequest &request)
{
    Q_ASSERT_X(!isTokenRequired() || !m_token.isEmpty(),
               objectName().toLatin1(),
               "This request require token and it's not provided!");

    if (!m_token.isEmpty()) {
        request.setRawHeader(QByteArray("Authorization"),
                             QStringLiteral("%1 %2").arg("Token", m_token).toLatin1());
    }
}
