#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QThread>
#include <QVariantList>
#include <QVariant>

class FileManager;

class DataManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList projects  READ getProjects WRITE setProjects)
    Q_PROPERTY(QVariantList joinedProjects  READ getJoinedProjects WRITE setJoinedProjects)
    Q_PROPERTY(QVariantList workList  READ getWorkList WRITE setWorkList)

public:
    explicit DataManager(QObject *parent = nullptr);
    QVariantList getProjects() const;
    QVariantList getJoinedProjects() const;
    QVariantList getWorkList() const;
    void cleanData();
    void projectsDataReceived(const QVariantList &projects, const QVariantList &joinedProjects);
    void workDataReceived(const QVariantList &work);

public slots:
    void setProjects(const QVariantList &projects);
    void setJoinedProjects(const QVariantList &joinedProjects);
    void setWorkList(const QVariantList &work);
signals:
    void displayPhoto(const QString &filePath);
    void photoError();
private:
    QThread *m_workerThread;
    FileManager *m_fileManager;
    QVariantList m_projects;
    QVariantList m_joinedProjects;
    QVariantList m_workList;
};

#endif // DATAMANAGER_H
