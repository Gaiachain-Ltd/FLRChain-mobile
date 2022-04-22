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

#include "types.h"

class QThread;
class FileManager;
class TransactionsModel;
class WorkModel;

class DataManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(Project* detailedProject READ detailedProject NOTIFY detailedProjectChanged)
    Q_PROPERTY(Task* detailedTask READ detailedTask NOTIFY detailedTaskChanged)

public:
    explicit DataManager(QObject *parent = nullptr);
    ~DataManager();

    void cleanData();

    Q_INVOKABLE QString getPhotosPath();
    Q_INVOKABLE void cleanPhotosDir();
    Q_INVOKABLE void removeCurrentWorkPhoto();

    ProjectModel *projectsModel() const;
    Project *detailedProject() const;
    Task *detailedTask() const;
    TransactionsModel *transactionsModel() const;
    WorkModel *workModel() const;

public slots:
    void onProjectDetailsReply(const QJsonObject &projectDetails);
    void onTaskDetailsReply(const QJsonObject &taskDetails);

signals:
    void displayPhoto(const QString &filePath);
    void photoError();
    void projectDetailsReceived(Project *project);
    void processingPhoto();
    void photoDownloadResult(const int workId, const QString &path);
    void projectsDataReply(const QJsonObject &projects);
    void transactionsDataReply(const QJsonArray &transactions);
    void downloadRequest(const QString &photoPath, const int workId);
    void detailedProjectChanged();
    void detailedTaskChanged();
    void myTasksReceived(const QVariantList &myTasks);

private:
    ProjectModelPtr m_projectsModel;
    ProjectPtr m_detailedProject;
    TaskPtr m_detailedTask;
    QScopedPointer<TransactionsModel, QScopedPointerDeleteLater> m_transactionsModel;
    QScopedPointer<WorkModel, QScopedPointerDeleteLater> m_workModel;
    QThread *m_workerThread;
    QScopedPointer<FileManager, QScopedPointerDeleteLater> m_fileManager;
};

#endif // DATAMANAGER_H
