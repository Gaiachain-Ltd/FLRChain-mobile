#include "project.h"

Project::Project() :
    m_id(),
    m_name(QString()),
    m_description(QString()),
    m_joined(0),
    m_status(QString()),
    m_deadline(QString()),
    m_investmentStart(QString()),
    m_investmentEnd(QString()),
    m_photo(QString()),
    m_tasks(QVariantList())
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

bool Project::joined() const
{
    return m_joined;
}

QString Project::status() const
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

QVariantList Project::tasks() const
{
    return m_tasks;
}

void Project::setId(const int id)
{
    m_id = id;
}

void Project::setName(const QString &name)
{
    m_name = name;
}

void Project::setDescription(const QString &description)
{
    m_description = description;
}

void Project::setJoined(const bool joined)
{
    m_joined = joined;
}

void Project::setStatus(const QString &status)
{
    m_status = status;
}

void Project::setDeadline(const QString &deadline)
{
    m_deadline = deadline;
}

void Project::setInvestmentStart(const QString &investmentStart)
{
    m_investmentStart = investmentStart;
}

void Project::setInvestmentEnd(const QString &investmentEnd)
{
    m_investmentEnd = investmentEnd;
}

void Project::setPhoto(const QString &photo)
{
    m_status = photo;
}

void Project::setTasks(const QVariantList &tasks)
{
    m_tasks = tasks;
}
