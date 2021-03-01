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

public:
    explicit DataManager(QObject *parent = nullptr);
    QVariantList getProjects() const;
    QVariantList getJoinedProjects() const;
    void cleanData();
    void getProjectsData(const QVariantList &projects, const QVariantList &joinedProjects);
public slots:
    void setProjects(const QVariantList &projects);
    void setJoinedProjects(const QVariantList &joinedProjects);
signals:
    void displayPhoto(const QString &filePath);
    void photoError();
private:
    QThread *m_workerThread;
    FileManager *m_manager;
    QVariantList m_projects;
    QVariantList m_joinedProjects;
};

#endif // DATAMANAGER_H
