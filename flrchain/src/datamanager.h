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
    Q_PROPERTY(QVariantList projects  READ getProjects WRITE setProjects NOTIFY projectsChanged)
    Q_PROPERTY(QVariantList workList  READ getWorkList WRITE setWorkList NOTIFY workListChanged)

public:
    explicit DataManager(QObject *parent = nullptr);
    QVariantList getProjects() const;
    QVariantList getWorkList() const;
    void cleanData();
    void projectsDataReceived(const QVariantList &projects);
    void workDataReceived(const QVariantList &work);

public slots:
    void setProjects(const QVariantList &projects);
    void setWorkList(const QVariantList &work);
signals:
    void displayPhoto(const QString &filePath);
    void photoError();
    void projectsChanged() const;
    void workListChanged() const;

private:
    QThread *m_workerThread;
    FileManager *m_fileManager;
    QVariantList m_projects;
    QVariantList m_workList;
};

#endif // DATAMANAGER_H
