#ifndef JOINPROJECTREQUEST_H
#define JOINPROJECTREQUEST_H

#include "apirequest.h"

#include <QObject>

class JoinProjectRequest: public ApiRequest
{
    Q_OBJECT
public:
    JoinProjectRequest(const int projectId, const QByteArray &token);
    void errorHandler(const QString &error);
signals:
    void joinProjectReply() const;
protected:
    virtual void parse() override final;
};

#endif // JOINPROJECTREQUEST_H
