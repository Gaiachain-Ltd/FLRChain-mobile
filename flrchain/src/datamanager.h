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
    void detailedProjectChanged();

private:
    QSharedPointer<ProjectModel> m_projectsModel;
    ProjectPtr m_detailedProject;
    QScopedPointer<TransactionsModel, QScopedPointerDeleteLater> m_transactionsModel;
    QScopedPointer<WorkModel, QScopedPointerDeleteLater> m_workModel;
    QThread *m_workerThread;
    QScopedPointer<FileManager, QScopedPointerDeleteLater> m_fileManager;
};

#endif // DATAMANAGER_H
