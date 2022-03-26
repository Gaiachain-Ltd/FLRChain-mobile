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

public:
    explicit DataManager(QObject *parent = nullptr);
    ~DataManager();

    void cleanData();
    void projectDetailsReply(const QJsonObject &projectObject);
    Q_INVOKABLE QString getPhotosPath();
    Q_INVOKABLE void cleanPhotosDir();
    Q_INVOKABLE void removeCurrentWorkPhoto();

    ProjectModel *projectsModel() const;
    TransactionsModel *transactionsModel() const;
    WorkModel *workModel() const;

public slots:
    void cashOutReplyReceived(const bool result);
    void joinProjectError();
    void addWorkError();

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

    ProjectModel *m_projectsModel;
    TransactionsModel *m_transactionsModel;
    WorkModel *m_workModel;
};

#endif // DATAMANAGER_H
