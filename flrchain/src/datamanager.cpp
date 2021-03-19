#include "datamanager.h"
#include "filemanager.h"
#include "project.h"
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
}

QVariantList DataManager::getWorkList() const
{
    return m_workList;
}

QVariantList DataManager::getTransactionsList() const
{
    return m_transactionsList;
}

double DataManager::getWalletBalance() const
{
    return m_walletBalance;
}

int DataManager::getProjectsCount() const
{
    return m_projectsCount;
}

void DataManager::setWorkList(const QVariantList &workList)
{
    m_workList = workList;
    emit workListChanged();
}

void DataManager::setTransactionsList(const QVariantList &transactionsList)
{
    m_transactionsList = transactionsList;
    emit transactionsListChanged();
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

void DataManager::cleanData()
{
    m_workList.clear();
    m_transactionsList.clear();
    m_fileManager->removeCurrentFile();
    m_projectsCount = 0;
    m_walletBalance = 0.0;
}

void DataManager::projectsDataReceived(const QVariantList &projects)
{
    emit projectsReceived(projects);
    setProjectsCount(projects.count());
}

void DataManager::workDataReceived(const QVariantList &workList)
{
    m_workList.clear();
    setWorkList(workList);
}

void DataManager::transactionsDataReceived(const QVariantList &transactionsList)
{
    m_transactionsList.clear();
    setTransactionsList(transactionsList);
}
