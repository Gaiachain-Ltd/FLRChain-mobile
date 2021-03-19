#ifndef PROJECTDETAILSREQUEST_H
#define PROJECTDETAILSREQUEST_H

#include "apirequest.h"

#include <QString>
#include <QObject>
#include "../project.h"

class ProjectDetailsRequest : public ApiRequest
{
    Q_OBJECT

public:
    ProjectDetailsRequest(const QByteArray &token, const int projectId);
    void errorHandler(const QString& error);
signals:
    void projectDetailsReply(Project *project) const;
protected:
    virtual void parse() override final;
};

#endif // PROJECTDETAILSREQUEST_H
