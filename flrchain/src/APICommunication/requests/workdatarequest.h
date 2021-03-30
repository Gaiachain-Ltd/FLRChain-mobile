#ifndef WORKDATAREQUEST_H
#define WORKDATAREQUEST_H


#include "apirequest.h"

#include <QString>
#include <QStringList>
#include <QObject>
#include <QJsonObject>

class WorkDataRequest : public ApiRequest
{
    Q_OBJECT

public:
    WorkDataRequest(const QByteArray &token, const int projectId);
    void errorHandler(const QString &error);
signals:
    void workDataReply(const QJsonObject &workReply) const;
protected:
    virtual void parse() override final;
};

#endif // WORKDATAREQUEST_H
