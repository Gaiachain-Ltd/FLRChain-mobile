#ifndef WORKDATAREQUEST_H
#define WORKDATAREQUEST_H


#include "apirequest.h"

#include <QString>
#include <QStringList>
#include <QObject>

class WorkDataRequest : public ApiRequest
{
    Q_OBJECT

public:
    WorkDataRequest(const QByteArray &token, const int projectId);
    void errorHandler(const QString &error);
signals:
    void workDataReply(QVariantList workList) const;
protected:
    virtual void parse() override final;
};

#endif // WORKDATAREQUEST_H
