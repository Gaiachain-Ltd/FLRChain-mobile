#ifndef SENDACTIVITYPHOTOREQUEST_H
#define SENDACTIVITYPHOTOREQUEST_H

#include "apimultipartrequest.h"

class SendActivityPhotoRequest : public ApiMultiPartRequest
{
    Q_OBJECT

public:
    SendActivityPhotoRequest(const QString &activityId,
                             const QFileInfo &photo,
                             const QByteArray &token);

signals:
    void activityPhotoUploaded();
    void activityPhotoUploadFailed(const QString &errorMessage);

private:
    void parse() final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;
};

#endif // SENDACTIVITYPHOTOREQUEST_H
