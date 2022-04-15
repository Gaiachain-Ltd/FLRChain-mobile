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

#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QThread>
#include <QVariantList>
#include <QVariant>

#include "project.h"
#include "projectmodel.h"
#include "transactionsmodel.h"
#include "workmodel.h"

class FileManager;

class DataManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(Project* detailedProject READ detailedProject NOTIFY detailedProjectChanged)

public:
    explicit DataManager(QObject *parent = nullptr);
    ~DataManager();

    void cleanData();
    void projectDetailsReply(const QJsonObject &projectObject);

    Q_INVOKABLE QString getPhotosPath();
    Q_INVOKABLE void cleanPhotosDir();
    Q_INVOKABLE void removeCurrentWorkPhoto();
    Q_INVOKABLE void loadProjectDetails(const int projectId);

    ProjectModel *projectsModel() const;
    Project *detailedProject() const;
    TransactionsModel *transactionsModel() const;
    WorkModel *workModel() const;

public slots:
    void cashOutReplyReceived(const bool result);
    void joinProjectError();
    void addWorkError();
    void saveUserInfoReplyReceived(bool result);
    void changePasswordReplyReceived(bool result);

signals:
    void displayPhoto(const QString &filePath);
    void photoError();
    void joinRequestSent(const int projectId);
    void projectDetailsReceived(Project *project);
    void processingPhoto();
    void photoDownloadResult(const int workId, const QString &path);
    void workAdded(const QString &taskName, const QString &projectName);
    void workAdditionFailed();
    void walletBalanceReceived(const double balance);
    void walletQRCodeReceived(const QString &qrCode);
    void facilitatorListReceived(const QJsonArray &facilitators);
    void projectsDataReply(const QJsonObject &projects);
    void transactionsDataReply(const QJsonArray &transactions);
    void workReply(const QJsonObject &work);
    void downloadRequest(const QString &photoPath, const int workId);
    void resetPasswordReplyReceived(bool result);
    void detailedProjectChanged();
    void myTasksReceived(const QVariantList &myTasks);

private:
    QSharedPointer<ProjectModel> m_projectsModel;
    ProjectPtr m_detailedProject;
    QScopedPointer<TransactionsModel, QScopedPointerDeleteLater> m_transactionsModel;
    QScopedPointer<WorkModel, QScopedPointerDeleteLater> m_workModel;
    QThread *m_workerThread;
    QScopedPointer<FileManager, QScopedPointerDeleteLater> m_fileManager;
};

#endif // DATAMANAGER_H
