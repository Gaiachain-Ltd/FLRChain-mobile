#include "datamanager.h"
#include "filemanager.h"

DataManager::DataManager(QObject *parent) : QObject(parent)
{
    m_manager = new FileManager;
    m_workerThread = new QThread();
    m_manager->moveToThread(m_workerThread);
    m_workerThread->start();

    connect(m_manager, &FileManager::displayPhoto,
            this, &DataManager::displayPhoto);
    connect(m_manager, &FileManager::photoError,
            this, &DataManager::photoError);
}
