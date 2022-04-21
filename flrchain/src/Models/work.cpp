/*
 * Copyright (C) 2022  Milo Solutions
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

#include "work.h"

Work::Work(QObject *parent):
    QObject(parent),
    m_id(),
    m_projectId(),
    m_status(QString()),
    m_date(QString()),
    m_photoPath(QString()),
    m_localPath(QString()),
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

QString Work::localPath() const
{
    return m_localPath;
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

void Work::setAmount(const double amount)
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
