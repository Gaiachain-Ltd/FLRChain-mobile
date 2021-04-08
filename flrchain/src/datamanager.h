#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QThread>
#include <QVariantList>
#include <QVariant>
#include "project.h"
#include "projectsmodel.h"
#include "transactionsmodel.h"
#include "workmodel.h"
#include "tasksmodel.h"

class FileManager;

class DataManager : public QObject
{
    Q_OBJECT

public:
    explicit DataManager(QObject *parent = nullptr);
    ~DataManager();
    void cleanData();
    void projectDetailsReply(const QJsonObject &projectObject);
    Q_INVOKABLE QString getPhotosPath();
    Q_INVOKABLE void cleanPhotosDir();
    Q_INVOKABLE void removeCurrentWorkPhoto();

    ProjectsModel *projectsModel() const;
    TransactionsModel *transactionsModel() const;
    WorkModel *workModel() const;
    TasksModel *tasksModel() const;

public slots:
    void cashOutReplyReceived(const bool result);
    void joinProjectError();
    void addWorkError();
    void projectTasksReceived();
signals:
    void displayPhoto(const QString &filePath);
    void photoError();
    void joinRequestSent(const int projectId) const;
    void projectDetailsReceived(Project *project);
    void processingPhoto();
    void photoDownloadResult(const int workId, const QString &path) const;
    void workAdded(const QString &taskName, const QString &projectName) const;
    void walletBalanceReceived(const double balance) const;
    void projectsDataReply(const QJsonObject &projects);
    void transactionsDataReply(const QJsonObject &transactions);
    void workReply(const QJsonObject &work);
    void downloadRequest(const QString &photoPath, const int workId);

private:
    QThread *m_workerThread;
    FileManager *m_fileManager;
    Project *m_detailedProject;

    ProjectsModel *m_projectsModel;
    TransactionsModel *m_transactionsModel;
    WorkModel *m_workModel;
    TasksModel *m_tasksModel;
};

#endif // DATAMANAGER_H
