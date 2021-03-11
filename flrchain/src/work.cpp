#include "work.h"

Work::Work(QObject *parent):
    QObject(parent),
    m_id(),
    m_projectId(),
    m_status(QString()),
    m_date(QString()),
    m_photoPath(QString()),
    m_amount(0.0)
{

}

int Work::id() const
{
    return m_id;
}

int Work::projectId() const
{
    return m_projectId;
}

QString Work::status() const
{
    return m_status;
}

QString Work::date() const
{
    return m_date;
}

QString Work::photoPath() const
{
    return m_photoPath;
}

double Work::amount() const
{
    return m_amount;
}

void Work::setId(const int id)
{
    m_id = id;
}

void Work::setProjectId(const int id)
{
    m_projectId = id;
}

void Work::setPhotoPath(const QString &photoPath)
{
    m_photoPath = photoPath;
}

void Work::setAmount(const double amount)
{
    m_amount = amount;
}

void Work::setStatus(const QString &status)
{
    m_status = status;
}

void Work::setDate(const QString &date)
{
    m_date = date;
}
