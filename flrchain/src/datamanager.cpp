﻿#include "datamanager.h"
#include "filemanager.h"
#include "pagemanager.h"

#include <QDebug>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

DataManager::DataManager(QObject *parent) :
    QObject(parent),
    m_projectsModel(new ProjectModel),
    m_detailedProject(Project::emptyProject()),
    m_transactionsModel(new TransactionsModel),
    m_workModel(new WorkModel),
    m_workerThread(new QThread),
    m_fileManager(new FileManager)
{
    connect(this, &DataManager::projectsDataReply,
            m_projectsModel.get(), &ProjectModel::reloadFromJson, Qt::QueuedConnection);
    connect(this, &DataManager::transactionsDataReply,
            m_transactionsModel.get(), &TransactionsModel::parseJsonObject, Qt::QueuedConnection);
    connect(this, &DataManager::workReply,
            m_workModel.get(), &WorkModel::parseJsonObject, Qt::QueuedConnection);
    connect(m_workModel.get(), &WorkModel::downloadPhoto,
            this, &DataManager::downloadRequest, Qt::QueuedConnection);
    connect(this, &DataManager::photoDownloadResult,
            m_workModel.get(), &WorkModel::photoDownloadResult, Qt::QueuedConnection);

    m_fileManager->moveToThread(m_workerThread);
    m_workerThread->start();

    connect(m_fileManager.get(), &FileManager::displayPhoto,
            this, &DataManager::displayPhoto);
    connect(m_fileManager.get(), &FileManager::photoError,
            this, &DataManager::photoError);
    connect(m_fileManager.get(), &FileManager::processingPhoto,
            this, &DataManager::processingPhoto);
    connect(m_workerThread, &QThread::finished,
            m_workerThread, &QThread::deleteLater);
}

DataManager::~DataManager()
{
    m_workerThread->quit();
    m_workerThread->wait();

    cleanData();
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

void DataManager::cleanPhotosDir()
{
    m_fileManager->cleanDir();
}

void DataManager::removeCurrentWorkPhoto()
{
    m_fileManager->removeCurrentFile();
}

void DataManager::loadProjectDetails(const int projectId)
{
    m_detailedProject = m_projectsModel->projectWithId(projectId);
    emit detailedProjectChanged();
}

ProjectModel *DataManager::projectsModel() const
{
    return m_projectsModel.get();
}

Project *DataManager::detailedProject() const
{
    return m_detailedProject.get();
}

TransactionsModel *DataManager::transactionsModel() const
{
    return m_transactionsModel.get();
}

WorkModel *DataManager::workModel() const
{
    return m_workModel.get();
}

void DataManager::projectDetailsReply(const QJsonObject &projectObject)
{
    Q_UNUSED(projectObject)
}
