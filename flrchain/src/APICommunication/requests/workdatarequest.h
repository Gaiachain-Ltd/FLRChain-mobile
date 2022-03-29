#ifndef WORKDATAREQUEST_H
#define WORKDATAREQUEST_H

#include "apirequest.h"

class WorkDataRequest : public ApiRequest
{
    Q_OBJECT

public:
    WorkDataRequest(const QByteArray &token, const int projectId);

signals:
    void workDataReply(const QJsonObject &workReply) const;

private:
    void parse() final;
};

#endif // WORKDATAREQUEST_H
