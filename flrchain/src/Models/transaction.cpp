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

#include "transaction.h"

Transaction::Transaction(QObject *parent) :
    QObject(parent),
    m_id(),
    m_title(QString()),
    m_action(0),
    m_amount(0),
    m_status(2)
{

}

int Transaction::id() const
{
    return m_id;
}

QString Transaction::title() const
{
    return m_title;
}

int Transaction::action() const
{
    return m_action;
}

double Transaction::amount() const
{
    return m_amount;
}

QString Transaction::creationDate() const
{
    return m_creationDate;
}

int Transaction::status() const
{
    return m_status;
}

void Transaction::setId(const int id)
{
    if (m_id != id) {
        m_id = id;
        emit idChanged(id);
    }
}

void Transaction::setTitle(const QString &title)
{
    if (m_title != title) {
        m_title = title;
        emit titleChanged(title);
    }
}

void Transaction::setAction(const int action)
{
    if (m_action != action) {
        m_action = action;
        emit actionChanged(action);
    }
}

void Transaction::setAmount(const double amount)
{
    if (m_amount != amount) {
        m_amount = amount;
        emit amountChanged(amount);
    }
}

void Transaction::setCreationDate(const QString &creationDate)
{
    if (m_creationDate != creationDate) {
        m_creationDate = creationDate;
        emit creationDateChanged(creationDate);
    }
}

void Transaction::setStatus(int status)
{
    if (m_status == status)
        return;

    m_status = status;
    emit statusChanged(m_status);
}
