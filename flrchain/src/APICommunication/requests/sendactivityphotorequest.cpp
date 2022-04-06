#include "sendactivityphotorequest.h"

SendActivityPhotoRequest::SendActivityPhotoRequest(const QString &activityId,
                                                   const QFileInfo &photo,
                                                   const QByteArray &token)
    : ApiMultiPartRequest(QLatin1String("projects/activity/%1/photo").arg(activityId))
{
    setType(Type::Post);
    setToken(token);

    addPart(QLatin1String("file"), photo);
}

void SendActivityPhotoRequest::parse()
{
    emit activityPhotoUploaded();
}

void SendActivityPhotoRequest::handleError(const QString &errorMessage,
                                           const QNetworkReply::NetworkError errorCode)
{
    qCritical() << "HTTP response" << errorCode << errorMessage;

    emit activityPhotoUploadFailed(errorMessage);
}
