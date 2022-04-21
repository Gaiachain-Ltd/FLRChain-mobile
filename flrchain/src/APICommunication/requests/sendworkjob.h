/*
 * Copyright (C) 2022  Milo Solutions
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

#ifndef SENDWORKJOB_H
#define SENDWORKJOB_H

#include <QObject>
#include <QPointer>
#include <QScopedPointer>
#include <QVariantMap>

#include "types.h"

class RestAPIClient;

DECLARE_SHARED_POINTER(CreateActivityRequest)
DECLARE_SHARED_POINTER_WITH_LIST(SendActivityPhotoRequest);

class SendWorkJob : public QObject
{
    Q_OBJECT

public:
    explicit SendWorkJob(RestAPIClient *restApiClient,
                         const int projectId,
                         const int taskId,
                         const QVariantMap &activityData,
                         const QStringList &activityPhotos,
                         const QByteArray &token,
                         QObject *parent = nullptr);

    void startJob();

signals:
    void started();
    void finished(const QString &projectName, const QString &taskName);
    void failed(const QString &errorMessage);

private slots:
    void onActivityCreated(const QJsonObject &activityData);
    void onActivityCreationFailed(const QString &errorMessage);
    void onActivityPhotoUploaded();
    void onActivityPhotoUploadFailed(const QString &errorMessage);

private:
    QPointer<RestAPIClient> m_apiClient;
    QStringList m_activityPhotos;
    QByteArray m_token;
    CreateActivityRequestPtr m_createActivityRequest;
    SendActivityPhotoRequestList m_sendPhotoRequests;
    SendActivityPhotoRequestList::iterator m_currentPhoto;
    QString m_projectName;
    QString m_taskName;
};

#endif // SENDWORKJOB_H
