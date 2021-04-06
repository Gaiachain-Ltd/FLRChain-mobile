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
    m_detailedProject(new Project())
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
}

DataManager::~DataManager()
{
    m_workerThread->quit();
    m_workerThread->wait();
    m_fileManager->deleteLater();
    m_detailedProject->deleteLater();
    cleanData();
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
    clearProjects();
    clearWork();
    clearTasks();
    clearTransactions();
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

void DataManager::clearProjects()
{
    if(m_projects.size() > 0){
        qDeleteAll(m_projects);
        m_projects.clear();
    }
}

void DataManager::clearTransactions()
{
    if(m_transactions.size() > 0){
        qDeleteAll(m_transactions);
        m_transactions.clear();
    }
}

void DataManager::clearWork()
{
    if(m_work.size() > 0){
        qDeleteAll(m_work);
        m_work.clear();
    }
}

void DataManager::clearTasks()
{
    if(m_tasks.size() > 0){
        qDeleteAll(m_tasks);
        m_tasks.clear();
    }
}

void DataManager::projectsDataReply(const QJsonObject &response)
{
    clearProjects();

    QJsonArray projectsArray = response.value(QLatin1String("results")).toArray();

    const int arraySize = projectsArray.count();
    if(arraySize == 0) {
        qDebug("No resources available");
        return;
    }

    for(int i = 0; i < arraySize; ++i) {
        QJsonObject projectObject = projectsArray.at(i).toObject();

        Project *project = new Project();
        project->setId(projectObject.value(QLatin1String("id")).toInt());
        project->setName(projectObject.value(QLatin1String("title")).toString());
        if(projectObject.value(QLatin1String("assignment_status")).isNull()){
            project->setAssignmentStatus(-1);
        }
        else {
            project->setAssignmentStatus(projectObject.value(QLatin1String("assignment_status")).toInt());
        }

        if(projectObject.value(QLatin1String("investment")).isNull()){
            project->setStatus(-1);
        }
        else {
            project->setStatus(projectObject.value(QLatin1String("investment")).toObject()
                               .value(QLatin1String("status")).toInt());
        }
        QDateTime deadline = QDateTime::fromString(projectObject.value(QLatin1String("end")).toString(), Qt::ISODate);
        project->setDeadline(deadline.toString(QLatin1String("MMMM dd, yyyy")));
        QDateTime start = QDateTime::fromString(projectObject.value(QLatin1String("investment")).toObject().value(QLatin1String("start")).toString(), Qt::ISODate);
        project->setInvestmentStart(start.toString(QLatin1String("MMMM dd, yyyy")));
        QDateTime end = QDateTime::fromString(projectObject.value(QLatin1String("investment")).toObject().value(QLatin1String("end")).toString(), Qt::ISODate);
        project->setInvestmentEnd(end.toString(QLatin1String("MMMM dd, yyyy")));
        project->setDescription(projectObject.value(QLatin1String("description")).toString());
        project->setPhoto(projectObject.value(QLatin1String("photo")).toString());

        m_projects.append(project);
    }
    emit projectsReceived(m_projects);
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
    }
    else {
        m_detailedProject->setStatus(projectObject.value(QLatin1String("investment")).toObject()
                           .value(QLatin1String("status")).toInt());
    }
    QDateTime deadline = QDateTime::fromString(projectObject.value(QLatin1String("end")).toString(), Qt::ISODate);
    m_detailedProject->setDeadline(deadline.toString(QLatin1String("MMMM dd, yyyy")));
    QDateTime start = QDateTime::fromString(projectObject.value(QLatin1String("investment")).toObject().value(QLatin1String("start")).toString(), Qt::ISODate);
    m_detailedProject->setInvestmentStart(start.toString(QLatin1String("MMMM dd, yyyy")));
    QDateTime end = QDateTime::fromString(projectObject.value(QLatin1String("investment")).toObject().value(QLatin1String("end")).toString(), Qt::ISODate);
    m_detailedProject->setInvestmentEnd(end.toString(QLatin1String("MMMM dd, yyyy")));
    m_detailedProject->setDescription(projectObject.value(QLatin1String("description")).toString());
    m_detailedProject->setPhoto(projectObject.value(QLatin1String("photo")).toString());

    QJsonArray tasksArray = projectObject.value(QLatin1String("tasks")).toArray();
    const int tasksArraySize = tasksArray.count();

    clearTasks();

    for(int i = 0; i < tasksArraySize; ++i) {
        QJsonObject taskObject = tasksArray.at(i).toObject();
        Task *task = new Task();
        task->setProjectId(m_detailedProject->id());
        task->setTaskId(taskObject.value(QLatin1String("id")).toInt());
        task->setAction(taskObject.value(QLatin1String("action")).toString());
        task->setReward(taskObject.value(QLatin1String("reward")).toString().toDouble());

        m_tasks.append(task);
    }
    m_detailedProject->setTasks(m_tasks);
    emit projectDetailsReceived(m_detailedProject);
}

void DataManager::transactionsDataReply(const QJsonObject &response)
{
    clearTransactions();

    QJsonArray walletArray = response.value(QLatin1String("results")).toArray();

    const int arraySize = walletArray.count();
    if(arraySize == 0) {
        qDebug("No resources available");
        return;
    }

    for(int i = 0; i < arraySize; ++i) {
        QJsonObject projectObject = walletArray.at(i).toObject();

        Transaction *transaction = new Transaction();
        transaction->setId(projectObject.value(QLatin1String("id")).toInt());
        transaction->setTitle(projectObject.value(QLatin1String("project_name")).toString());
        transaction->setAmount(projectObject.value(QLatin1String("amount")).toString().toDouble());
        QDateTime date = QDateTime::fromString(projectObject.value(QLatin1String("created")).toString(), Qt::ISODate);
        transaction->setCreationDate(date.toString(QLatin1String("dd.MM.yyyy")));

        m_transactions.append(transaction);
    }

    emit transactionsDataReceived(m_transactions);
}

void DataManager::workReply(const QJsonObject &response)
{
    clearWork();

    QJsonArray workArray = response.value(QLatin1String("results")).toArray();

    double rewardsBalance = 0;
    const int arraySize = workArray.count();

    for(int i = 0; i < arraySize; ++i) {
        QJsonObject workObject = workArray.at(i).toObject();

        Work *work = new Work();
        work->setId(workObject.value(QLatin1String("id")).toInt());
        work->setProjectId(workObject.value(QLatin1String("projectId")).toInt());

        work->setStatus(workObject.value(QLatin1String("status")).toString());
        QDateTime date = QDateTime::fromString(workObject.value(QLatin1String("created")).toString(), Qt::ISODate);
        work->setDate(date.toString(QLatin1String("MMMM dd, yyyy")));
        work->setPhotoPath(workObject.value(QLatin1String("photo")).toString());
        work->setAmount(workObject.value(QLatin1String("task")).toObject().value(QLatin1String("reward")).toString().toDouble());
        rewardsBalance += work->amount();

        m_work.append(work);
    }
    emit workReceived(m_work, rewardsBalance);
}
