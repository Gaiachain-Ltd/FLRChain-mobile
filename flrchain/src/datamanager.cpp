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
    m_detailedProject(new Project()),
    m_projectsModel(new ProjectsModel()),
    m_transactionsModel(new TransactionsModel()),
    m_workModel(new WorkModel()),
    m_tasksModel(new TasksModel())
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

    connect(this, &DataManager::projectsDataReply, m_projectsModel, &ProjectsModel::parseJsonObject, Qt::QueuedConnection);
    connect(this, &DataManager::transactionsDataReply, m_transactionsModel, &TransactionsModel::parseJsonObject, Qt::QueuedConnection);
    connect(this, &DataManager::workReply, m_workModel, &WorkModel::parseJsonObject, Qt::QueuedConnection);
    connect(m_workModel, &WorkModel::downloadPhoto, this, &DataManager::downloadRequest, Qt::QueuedConnection);
    connect(this, &DataManager::photoDownloadResult, m_workModel, &WorkModel::photoDownloadResult, Qt::QueuedConnection);
    connect(m_tasksModel, &TasksModel::tasksReceived, this, &DataManager::projectTasksReceived, Qt::QueuedConnection);
}

DataManager::~DataManager()
{
    m_workerThread->quit();
    m_workerThread->wait();
    m_fileManager->deleteLater();
    m_detailedProject->deleteLater();
    cleanData();
    m_projectsModel->deleteLater();
    m_tasksModel->deleteLater();
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
    m_tasksModel->clear();
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

ProjectsModel *DataManager::projectsModel() const
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

TasksModel *DataManager::tasksModel() const
{
    return m_tasksModel;
}

void DataManager::projectDetailsReply(const QJsonObject &projectObject)
{
    m_detailedProject->setId(projectObject.value(QLatin1String("id")).toInt());
    m_detailedProject->setName(projectObject.value(QLatin1String("title")).toString());
    if(projectObject.value(QLatin1String("assignment_status")).isNull()){
        m_detailedProject->setAssignmentStatus(-1);
    }
    else {
        m_detailedProject->setAssignmentStatus(projectObject.value(QLatin1String("assignment_status")).toInt());
    }

    if(projectObject.value(QLatin1String("investment")).isNull()){
        m_detailedProject->setStatus(-1);
        m_detailedProject->setConfirmed(false);
    }
    else {
        const QJsonObject &investment = projectObject.value(QLatin1String("investment")).toObject();
        m_detailedProject->setStatus(investment.value(QLatin1String("status")).toInt());
        m_detailedProject->setConfirmed(investment.value(QLatin1String("confirmed")).toBool());
    }
    QDateTime deadline = QDateTime::fromString(projectObject.value(QLatin1String("end")).toString(), Qt::ISODate);
    m_detailedProject->setDeadline(deadline.toString(QLatin1String("MMMM dd, yyyy")));
    QDateTime start = QDateTime::fromString(projectObject.value(QLatin1String("investment")).toObject().value(QLatin1String("start")).toString(), Qt::ISODate);
    m_detailedProject->setInvestmentStart(start.toString(QLatin1String("MMMM dd, yyyy")));
    QDateTime end = QDateTime::fromString(projectObject.value(QLatin1String("investment")).toObject().value(QLatin1String("end")).toString(), Qt::ISODate);
    m_detailedProject->setInvestmentEnd(end.toString(QLatin1String("MMMM dd, yyyy")));
    m_detailedProject->setDescription(projectObject.value(QLatin1String("description")).toString());
    m_detailedProject->setPhoto(projectObject.value(QLatin1String("photo")).toString());

    m_tasksModel->parseJsonObject(projectObject);
}

void DataManager::projectTasksReceived(){
    emit projectDetailsReceived(m_detailedProject);
}
