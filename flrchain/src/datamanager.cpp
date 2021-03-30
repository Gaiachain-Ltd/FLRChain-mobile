#include "datamanager.h"
#include "filemanager.h"
#include "pagemanager.h"
#include "task.h"
#include "work.h"
#include "transaction.h"
#include <QDebug>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>


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
    connect(m_workerThread, &QThread::finished, m_workerThread, &QThread::deleteLater);
}

DataManager::~DataManager()
{
    m_workerThread->quit();
    m_workerThread->wait();
    m_fileManager->deleteLater();
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

void DataManager::projectsDataReply(const QJsonObject &response)
{
    QVariantList projectsList;

    QJsonArray projectsArray = response.value(QLatin1String("results")).toArray();

    const int arraySize = projectsArray.count();
    if(arraySize == 0) {
        qDebug("No resources available");
        return;
    }

    for(int i = 0; i < arraySize; ++i) {
        QJsonObject projectObject = projectsArray.at(i).toObject();

        Project *project = new Project(this);
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

        project->setDeadline(projectObject.value(QLatin1String("end")).toString());
        project->setInvestmentStart(projectObject.value(QLatin1String("start")).toString());
        project->setInvestmentEnd(projectObject.value(QLatin1String("end")).toString());
        project->setDescription(projectObject.value(QLatin1String("description")).toString());
        project->setPhoto(projectObject.value(QLatin1String("photo")).toString());

        QJsonArray tasksArray = projectObject.value(QLatin1String("tasks")).toArray();
        QVariantList tasksList;
        const int tasksArraySize = tasksArray.count();
        for(int i = 0; i < tasksArraySize; ++i) {
            QJsonObject taskObject = tasksArray.at(i).toObject();
            Task *task = new Task(this);
            task->setProjectId(project->id());
            task->setTaskId(taskObject.value(QLatin1String("id")).toInt());
            task->setAction(taskObject.value(QLatin1String("action")).toString());
            task->setReward(taskObject.value(QLatin1String("reward")).toDouble());

            tasksList.append(QVariant::fromValue(task));
        }

        project->setTasks(tasksList);

        projectsList.append(QVariant::fromValue(project));
    }

    emit projectsReceived(projectsList);
    setProjectsCount(projectsList.count());
}

void DataManager::projectDetailsReply(const QJsonObject &projectObject)
{
    Project *project = new Project(this);
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
    project->setDeadline(projectObject.value(QLatin1String("end")).toString());
    project->setInvestmentStart(projectObject.value(QLatin1String("start")).toString());
    project->setInvestmentEnd(projectObject.value(QLatin1String("end")).toString());
    project->setDescription(projectObject.value(QLatin1String("description")).toString());
    project->setPhoto(projectObject.value(QLatin1String("photo")).toString());

    QJsonArray tasksArray = projectObject.value(QLatin1String("tasks")).toArray();
    QVariantList tasksList;
    const int tasksArraySize = tasksArray.count();
    for(int i = 0; i < tasksArraySize; ++i) {
        QJsonObject taskObject = tasksArray.at(i).toObject();
        Task *task = new Task(this);
        task->setProjectId(project->id());
        task->setTaskId(taskObject.value(QLatin1String("id")).toInt());
        task->setAction(taskObject.value(QLatin1String("action")).toString());
        task->setReward(taskObject.value(QLatin1String("reward")).toDouble());

        tasksList.append(QVariant::fromValue(task));
    }
    project->setTasks(tasksList);
    emit projectDetailsReceived(project);
}

void DataManager::transactionsDataReply(const QJsonObject &response)
{
    QVariantList walletList;

    QJsonArray walletArray = response.value(QLatin1String("results")).toArray();

    const int arraySize = walletArray.count();
    if(arraySize == 0) {
        qDebug("No resources available");
        return;
    }

    for(int i = 0; i < arraySize; ++i) {
        QJsonObject projectObject = walletArray.at(i).toObject();

        Transaction *transaction = new Transaction(this);
        transaction->setId(projectObject.value(QLatin1String("id")).toInt());
        transaction->setTitle(projectObject.value(QLatin1String("title")).toString());
        transaction->setType(projectObject.value(QLatin1String("type")).toString());
        transaction->setAmount(projectObject.value(QLatin1String("amount")).toBool());

        walletList.append(QVariant::fromValue(transaction));
    }

    emit transactionsDataReceived(walletList);
}

void DataManager::workReply(const QJsonObject &response)
{
    QVariantList workList;

    QJsonArray workArray = response.value(QLatin1String("results")).toArray();

    int rewardsBalance = 0;
    const int arraySize = workArray.count();

    for(int i = 0; i < arraySize; ++i) {
        QJsonObject workObject = workArray.at(i).toObject();

        Work *work = new Work(this);
        work->setId(workObject.value(QLatin1String("id")).toInt());
        work->setProjectId(workObject.value(QLatin1String("projectId")).toInt());

        work->setStatus(workObject.value(QLatin1String("status")).toString());
        work->setDate(workObject.value(QLatin1String("date")).toString());
        work->setPhotoPath(workObject.value(QLatin1String("photo")).toString());
        work->setAmount(workObject.value(QLatin1String("task")).toObject().value(QLatin1String("reward")).toInt());
        rewardsBalance += work->amount();

        workList.append(QVariant::fromValue(work));
    }
    emit workReceived(workList, rewardsBalance);
}
