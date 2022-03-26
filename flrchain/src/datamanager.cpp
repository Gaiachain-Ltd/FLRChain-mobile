#include "datamanager.h"
#include "filemanager.h"
#include "pagemanager.h"

#include <QDebug>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

DataManager::DataManager(QObject *parent) :
    QObject(parent),
    m_workerThread(new QThread()),
    m_fileManager(new FileManager()),
    m_projectsModel(new ProjectModel()),
    m_transactionsModel(new TransactionsModel()),
    m_workModel(new WorkModel())
{
    m_fileManager->moveToThread(m_workerThread);
    m_workerThread->start();

    connect(m_fileManager, &FileManager::displayPhoto,
            this, &DataManager::displayPhoto);
    connect(m_fileManager, &FileManager::photoError,
            this, &DataManager::photoError);
    connect(m_fileManager, &FileManager::processingPhoto,
            this, &DataManager::processingPhoto);
    connect(m_workerThread, &QThread::finished, m_workerThread, &QThread::deleteLater);

    connect(this, &DataManager::projectsDataReply, m_projectsModel, &ProjectModel::reloadFromJson, Qt::QueuedConnection);
    connect(this, &DataManager::transactionsDataReply, m_transactionsModel, &TransactionsModel::parseJsonObject, Qt::QueuedConnection);
    connect(this, &DataManager::workReply, m_workModel, &WorkModel::parseJsonObject, Qt::QueuedConnection);
    connect(m_workModel, &WorkModel::downloadPhoto, this, &DataManager::downloadRequest, Qt::QueuedConnection);
    connect(this, &DataManager::photoDownloadResult, m_workModel, &WorkModel::photoDownloadResult, Qt::QueuedConnection);
}

DataManager::~DataManager()
{
    m_workerThread->quit();
    m_workerThread->wait();

    m_fileManager->deleteLater();
    cleanData();
    m_projectsModel->deleteLater();
    m_workModel->deleteLater();
    m_transactionsModel->deleteLater();
}

void DataManager::cashOutReplyReceived(const bool result)
{
    if (result) {
      PageManager::instance()->enterSuccessPopup("Cashed out successfully.");
    } else {
      PageManager::instance()->enterErrorPopup("Cash out request failed.");
    }
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
    m_projectsModel->clear();
    m_workModel->clear();
    m_transactionsModel->clear();
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

ProjectModel *DataManager::projectsModel() const
{
    return m_projectsModel;
}

TransactionsModel *DataManager::transactionsModel() const
{
    return m_transactionsModel;
}

WorkModel *DataManager::workModel() const
{
    return m_workModel;
}

void DataManager::projectDetailsReply(const QJsonObject &projectObject)
{
    Q_UNUSED(projectObject)
}
