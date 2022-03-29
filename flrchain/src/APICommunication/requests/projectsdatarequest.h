#ifndef PROJECTSDATAREQUEST_H
#define PROJECTSDATAREQUEST_H

#include "apirequest.h"

class ProjectsDataRequest : public ApiRequest
{
    Q_OBJECT

public:
    ProjectsDataRequest(const QByteArray &token);

signals:
    void projectsDataReply(const QJsonObject &projectsList) const;

private:
    void parse() final;
};

#endif // PROJECTSDATAREQUEST_H
