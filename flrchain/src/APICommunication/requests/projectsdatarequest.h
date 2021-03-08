#ifndef PROJECTSDATAREQUEST_H
#define PROJECTSDATAREQUEST_H

#include "apirequest.h"

#include <QString>
#include <QObject>

class ProjectsDataRequest : public ApiRequest
{
    Q_OBJECT

public:
    ProjectsDataRequest(const QByteArray &token);
    void errorHandler(const QString& error);
signals:
    void projectsDataReply(QVariantList projectsList, QVariantList joinedProjectsList) const;
protected:
    virtual void parse() override final;
};

#endif // PROJECTSDATAREQUEST_H
