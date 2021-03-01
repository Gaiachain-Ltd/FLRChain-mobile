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

void DataManager::setProjects(const QVariantList &projects)
{
    m_projects = projects;
}

void DataManager::setJoinedProjects(const QVariantList &joinedProjects)
{
    m_joinedProjects = joinedProjects;
}

void DataManager::cleanData()
{
   m_projects.clear();
   m_joinedProjects.clear();
}

void DataManager::getProjectsData(const QVariantList &projects, const QVariantList &joinedProjects)
{
    cleanData();

    setProjects(projects);
    setJoinedProjects(joinedProjects);
}
