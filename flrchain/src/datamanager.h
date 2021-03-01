#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QThread>

class FileManager;

class DataManager : public QObject
{
    Q_OBJECT

public:
    explicit DataManager(QObject *parent = nullptr);

signals:
    void displayPhoto(const QString &filePath);
    void photoError();
private:
    QThread *m_workerThread;
    FileManager *m_manager;
};

#endif // DATAMANAGER_H
