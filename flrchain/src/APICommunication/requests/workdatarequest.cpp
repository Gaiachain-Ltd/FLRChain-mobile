#include "workdatarequest.h"

#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include "../work.h"

WorkDataRequest::WorkDataRequest(const QByteArray &token) : ApiRequest("")
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

    QVariantList workList;

    QJsonArray workArray = response.value(QLatin1String("work")).toArray();

    const int arraySize = workArray.count();
    if(arraySize == 0) {
        qDebug("No resources available");
        return;
    }

    for(int i = 0; i < arraySize; ++i) {
        QJsonObject workObject = workArray.at(i).toObject();

        Work *work = new Work();
        work->setId(workObject.value(QLatin1String("id")).toInt());
        work->setProjectId(workObject.value(QLatin1String("projectId")).toInt());

        work->setStatus(workObject.value(QLatin1String("status")).toString());
        work->setDate(workObject.value(QLatin1String("date")).toString());
        work->setPhotoPath(workObject.value(QLatin1String("photo")).toString());
        work->setAmount(workObject.value(QLatin1String("amount")).toDouble());

        workList.append(QVariant::fromValue(work));
    }

    emit workDataReply(workList);
}
