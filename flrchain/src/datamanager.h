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
    Q_PROPERTY(double walletBalance READ getWalletBalance WRITE setWalletBalance NOTIFY walletBalanceChanged)
    Q_PROPERTY(int projectsCount READ getProjectsCount WRITE setProjectsCount NOTIFY projectsCountChanged)

public:
    explicit DataManager(QObject *parent = nullptr);
    int getProjectsCount() const;
    double getWalletBalance() const;
    void cleanData();
    void projectsDataReceived(const QVariantList &projects);
    Q_INVOKABLE QString getPhotosPath();
    Q_INVOKABLE void cleanPhotosDir();
    Q_INVOKABLE void removeCurrentWorkPhoto();
public slots:
    void setProjectsCount(const int count);
    void setWalletBalance(const double walletBalance);
    void cashOutReplyReceived(const bool result);
    void joinProjectError();
    void addWorkError();
signals:
    void displayPhoto(const QString &filePath);
    void photoError();
    void walletBalanceChanged() const;
    void projectsCountChanged() const;
    void joinRequestSent(const int projectId) const;
    void projectDetailsReceived(Project *project);
    void projectsReceived(const QVariantList &projects);
    void workReceived(const QVariantList &work, int rewardsBalance);
    void processingPhoto();
    void transactionsDataReceived(const QVariantList &transactions);
    void photoDownloaded(const QString &path, const int workId) const;
    void fileDownloadError(const int workId) const;
    void workAdded(const QString &taskName, const QString &projectName) const;

private:
    QThread *m_workerThread;
    FileManager *m_fileManager;
    double m_walletBalance = 0.0;
    int m_projectsCount = 0;
};

#endif // DATAMANAGER_H
