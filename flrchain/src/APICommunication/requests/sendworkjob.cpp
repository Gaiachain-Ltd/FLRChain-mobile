#include "sendworkjob.h"
#include "restapiclient.h"
#include "createactivityrequest.h"
#include "sendactivityphotorequest.h"

#include <QJsonObject>

SendWorkJob::SendWorkJob(RestAPIClient *restApiClient,
                         const int projectId,
                         const int taskId,
                         const QVariantMap &activityData,
                         const QStringList &activityPhotos,
                         const QByteArray &token,
                         QObject *parent)
    : QObject(parent)
    , m_apiClient(restApiClient)
    , m_activityPhotos(activityPhotos)
    , m_token(token)
    , m_createActivityRequest(new CreateActivityRequest(projectId, taskId, activityData, token))
{
    connect(m_createActivityRequest.get(), &CreateActivityRequest::activityCreated,
            this, &SendWorkJob::onActivityCreated);
    connect(m_createActivityRequest.get(), &CreateActivityRequest::activityCreationFailed,
            this, &SendWorkJob::onActivityCreationFailed);
}

void SendWorkJob::startJob()
{
    m_apiClient->send(m_createActivityRequest);

    emit started();
}

void SendWorkJob::onActivityCreated(const QJsonObject &activityData)
{
    m_projectName = activityData.value(u"project").toObject().value(u"title").toString();
    m_taskName = activityData.value(u"task").toObject().value(u"name").toString();

    auto activityId = activityData.value(u"id").toString();

    for (auto photo : qAsConst(m_activityPhotos)) {
        auto request = SendActivityPhotoRequestPtr::create(activityId, QFileInfo(photo.remove("file:/")), m_token);

        connect(request.get(), &SendActivityPhotoRequest::activityPhotoUploaded,
                this, &SendWorkJob::onActivityPhotoUploaded);
        connect(request.get(), &SendActivityPhotoRequest::activityPhotoUploadFailed,
                this, &SendWorkJob::onActivityPhotoUploadFailed);

        m_sendPhotoRequests.append(request);
    }

    m_currentPhoto = m_sendPhotoRequests.begin();

    if (m_currentPhoto != m_sendPhotoRequests.end()) {
        m_apiClient->send(*m_currentPhoto);
    } else {
        emit finished(m_projectName, m_taskName);
    }
}

void SendWorkJob::onActivityCreationFailed(const QString &errorMessage)
{
    emit failed(errorMessage);
}

void SendWorkJob::onActivityPhotoUploaded()
{
    m_currentPhoto++;

    if (m_currentPhoto != m_sendPhotoRequests.end()) {
        m_apiClient->send(*m_currentPhoto);
    } else {
        emit finished(m_projectName, m_taskName);
    }
}

void SendWorkJob::onActivityPhotoUploadFailed(const QString &errorMessage)
{
    emit failed(errorMessage);
}
