#include "datamanager.h"
#include "filemanager.h"
#include <QDebug>

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

QVariantList DataManager::getProjects() const
{
    return m_projects;
}

QVariantList DataManager::getJoinedProjects() const
{
    return m_joinedProjects;
}

QVariantList DataManager::getWorkList() const
{
    return m_workList;
}

void DataManager::setProjects(const QVariantList &projects)
{
    m_projects = projects;
}

void DataManager::setJoinedProjects(const QVariantList &joinedProjects)
{
    m_joinedProjects = joinedProjects;
}

void DataManager::setWorkList(const QVariantList &workList)
{
    m_workList = workList;
}

void DataManager::cleanData()
{
   m_projects.clear();
   m_joinedProjects.clear();
   m_workList.clear();
}

void DataManager::projectsDataReceived(const QVariantList &projects, const QVariantList &joinedProjects)
{
    m_projects.clear();
    m_joinedProjects.clear();
    setProjects(projects);
    setJoinedProjects(joinedProjects);
}

void DataManager::workDataReceived(const QVariantList &workList)
{
    m_workList.clear();
    setWorkList(workList);
}
