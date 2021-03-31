#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QThread>
#include <QVariantList>
#include <QVariant>
#include "project.h"

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
public slots:
    void cashOutReplyReceived(const bool result);
    void joinProjectError();
    void addWorkError();
signals:
    void displayPhoto(const QString &filePath);
    void photoError();
    void joinRequestSent(const int projectId) const;
    void projectDetailsReceived(Project *project);
    void projectsReceived(const QVariantList &projects);
    void workReceived(const QVariantList &work, double rewardsBalance);
    void processingPhoto();
    void transactionsDataReceived(const QVariantList &transactions);
    void photoDownloaded(const QString &path, const int workId) const;
    void fileDownloadError(const int workId) const;
    void workAdded(const QString &taskName, const QString &projectName) const;
    void walletBalanceReceived(const double balance) const;

private:
    QThread *m_workerThread;
    FileManager *m_fileManager;
};

#endif // DATAMANAGER_H
