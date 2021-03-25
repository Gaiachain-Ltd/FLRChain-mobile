#include "datamanager.h"
#include "filemanager.h"
#include "pagemanager.h"
#include <QDebug>

DataManager::DataManager(QObject *parent) : QObject(parent)
{
    m_fileManager = new FileManager;
    m_workerThread = new QThread();
    m_fileManager->moveToThread(m_workerThread);
    m_workerThread->start();

    connect(m_fileManager, &FileManager::displayPhoto,
            this, &DataManager::displayPhoto);
    connect(m_fileManager, &FileManager::photoError,
            this, &DataManager::photoError);
    connect(m_fileManager, &FileManager::processingPhoto,
            this, &DataManager::processingPhoto);
}

double DataManager::getWalletBalance() const
{
    return m_walletBalance;
}

int DataManager::getProjectsCount() const
{
    return m_projectsCount;
}

void DataManager::setWalletBalance(const double walletBalance)
{
    if (m_walletBalance != walletBalance) {
        m_walletBalance = walletBalance;
        emit walletBalanceChanged();
    }
}

void DataManager::setProjectsCount(const int projectsCount)
{
    if (m_projectsCount != projectsCount) {
        m_projectsCount = projectsCount;
        emit projectsCountChanged();
    }
}

void DataManager::cashOutReplyReceived(const bool result)
{
    qDebug() << "Cashout result" << result;
}

void DataManager::joinProjectError()
{
    PageManager::instance()->enterErrorPopup("Couldn't join the project. Try again");
}

void DataManager::addWorkError()
{
    PageManager::instance()->enterErrorPopup("Uploading photo failed. Try again");
}

void DataManager::cleanData()
{
    cleanPhotosDir();
    m_projectsCount = 0;
    m_walletBalance = 0.0;
}

void DataManager::projectsDataReceived(const QVariantList &projects)
{
    emit projectsReceived(projects);
    setProjectsCount(projects.count());
}

QString DataManager::getPhotosPath()
{
    return m_fileManager->photosPath();
}

void DataManager::cleanPhotosDir(){
    m_fileManager->cleanDir();
}

void DataManager::removeCurrentWorkPhoto(){
    m_fileManager->removeCurrentFile();
}
