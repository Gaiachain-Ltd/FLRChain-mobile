#ifndef SENDWORKREQUEST_H
#define SENDWORKREQUEST_H

#include "mmultipartrequest.h"
#include <QObject>


class SendWorkRequest : public MMultiPartRequest
{
    Q_OBJECT

public:
    SendWorkRequest(const QString &filePath, const int projectId, const int taskId, const QByteArray &token);
    void errorHandler(const QString& error);
signals:
    void workAdded(const QString &taskName, const QString &projectName) const;
    void sendWorkError() const;
protected:
    virtual void parse() override final;
    virtual void customizeRequest(QNetworkRequest &request) override;
};

#endif // SENDWORKREQUEST_H
