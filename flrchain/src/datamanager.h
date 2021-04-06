#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QThread>
#include <QVariantList>
#include <QVariant>
#include "project.h"
#include "transaction.h"
#include "work.h"
#include "task.h"

class FileManager;

class DataManager : public QObject
{
    Q_OBJECT

public:
    explicit DataManager(QObject *parent = nullptr);
    ~DataManager();
    void cleanData();
    void projectsDataReply(const QJsonObject &projects);
    void projectDetailsReply(const QJsonObject &projectObject);
    void transactionsDataReply(const QJsonObject &transactions);
    void workReply(const QJsonObject &work);
    Q_INVOKABLE QString getPhotosPath();
    Q_INVOKABLE void cleanPhotosDir();
    Q_INVOKABLE void removeCurrentWorkPhoto();

    void clearProjects();
    void clearTransactions();
    void clearWork();
    void clearTasks();

public slots:
    void cashOutReplyReceived(const bool result);
    void joinProjectError();
    void addWorkError();

signals:
    void displayPhoto(const QString &filePath);
    void photoError();
    void joinRequestSent(const int projectId) const;
    void projectDetailsReceived(Project *project);
    void projectsReceived(const  QList<Project*> &projects);
    void noProjectsData();
    void workReceived(const QList<Work*> &work, const double rewardsBalance);
    void processingPhoto();
    void transactionsDataReceived(const QList<Transaction*> &transactions);
    void noTransactionsData();
    void photoDownloaded(const QString &path, const int workId) const;
    void fileDownloadError(const int workId) const;
    void workAdded(const QString &taskName, const QString &projectName) const;
    void walletBalanceReceived(const double balance) const;

private:
    QThread *m_workerThread;
    FileManager *m_fileManager;
    QList<Project*> m_projects;
    QList<Transaction*> m_transactions;
    QList<Work*> m_work;
    QList<Task*> m_tasks;
    Project *m_detailedProject;
};

#endif // DATAMANAGER_H
