#include "work.h"

Work::Work(QObject *parent):
    QObject(parent),
    m_id(),
    m_projectId(),
    m_status(QString()),
    m_date(QString()),
    m_photoPath(QString()),
    m_localPath(QString()),
    m_amount(0)
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

QString Work::localPath() const
{
    return m_localPath;
}

int Work::amount() const
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
    if (m_photoPath != photoPath) {
        m_photoPath = photoPath;
        emit photoPathChanged(photoPath);
    }
}

void Work::setLocalPath(const QString &localPath)
{
    if (m_localPath != localPath) {
        m_localPath = localPath;
        emit localPathChanged(localPath);
    }
}

void Work::setAmount(const int amount)
{
    if (m_amount != amount) {
        m_amount = amount;
        emit amountChanged(amount);
    }
}

void Work::setStatus(const QString &status)
{
    if (m_status != status) {
        m_status = status;
        emit statusChanged(status);
    }
}

void Work::setDate(const QString &date)
{
    if (m_date != date) {
        m_date = date;
        emit dateChanged(date);
    }
}
