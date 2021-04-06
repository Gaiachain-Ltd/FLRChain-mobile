#include "project.h"

Project::Project(QObject *parent):
    QObject(parent),
    m_id(),
    m_name(QString()),
    m_description(QString()),
    m_status(),
    m_deadline(QString()),
    m_investmentStart(QString()),
    m_investmentEnd(QString()),
    m_photo(QString()),
    m_tasks(QList<Task *>()),
    m_assignmentStatus()
{

}

int Project::id() const
{
    return m_id;
}

QString Project::name() const
{
    return m_name;
}

QString Project::description() const
{
    return m_description;
}

int Project::status() const
{
    return m_status;
}

QString Project::deadline() const
{
    return m_deadline;
}

QString Project::investmentStart() const
{
    return m_investmentStart;
}

QString Project::investmentEnd() const
{
    return m_investmentEnd;
}

QString Project::photo() const
{
    return m_photo;
}

QList<Task *> Project::tasks() const
{
    return m_tasks;
}

int Project::assignmentStatus() const
{
    return m_assignmentStatus;
}

void Project::setId(const int id)
{
    if (m_id != id) {
        m_id = id;
        emit idChanged(id);
    }
}

void Project::setName(const QString &name)
{
    if (m_name != name) {
        m_name = name;
        emit nameChanged(name);
    }
}

void Project::setDescription(const QString &description)
{
    if (m_description != description) {
        m_description = description;
        emit descriptionChanged(description);
    }
}

void Project::setStatus(const int status)
{
    if (m_status != status) {
        m_status = status;
        emit statusChanged(status);
    }
}

void Project::setDeadline(const QString &deadline)
{
    if (m_deadline != deadline) {
        m_deadline = deadline;
        emit deadlineChanged(deadline);
    }
}

void Project::setInvestmentStart(const QString &investmentStart)
{
    if (m_investmentStart != investmentStart) {
        m_investmentStart = investmentStart;
        emit investmentStartChanged(investmentStart);
    }
}

void Project::setInvestmentEnd(const QString &investmentEnd)
{
    if (m_investmentEnd != investmentEnd) {
        m_investmentEnd = investmentEnd;
        emit investmentEndChanged(investmentEnd);
    }
}

void Project::setPhoto(const QString &photo)
{
    if (m_photo != photo) {
        m_photo = photo;
        emit photoChanged(photo);
    }
}

void Project::setTasks(const QList<Task *> &tasks)
{
    if (m_tasks != tasks) {
        m_tasks = tasks;
        emit tasksChanged(tasks);
    }
}

void Project::setAssignmentStatus(const int status)
{
    if (m_assignmentStatus != status) {
        m_assignmentStatus = status;
        emit assignmentStatusChanged(status);
    }
}
