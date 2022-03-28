#ifndef PROJECTDETAILSREQUEST_H
#define PROJECTDETAILSREQUEST_H

#include "apirequest.h"

class ProjectDetailsRequest : public ApiRequest
{
    Q_OBJECT

public:
    ProjectDetailsRequest(const QByteArray &token, const int projectId);
    void errorHandler(const QString& error);

signals:
    void projectDetailsReply(const QJsonObject &projectObject) const;

private:
    void parse() final;
};

#endif // PROJECTDETAILSREQUEST_H
