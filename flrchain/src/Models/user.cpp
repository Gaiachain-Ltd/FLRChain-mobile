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

#include "user.h"

User::User(QObject *parent) :
    QObject(parent)
{

}

QString User::email() const
{
    return m_email;
}

QString User::firstName() const
{
    return m_firstName;
}

QString User::lastName() const
{
    return m_lastName;
}

QByteArray User::password() const
{
    return m_password;
}

bool User::optedIn() const
{
    return m_optedIn;
}

void User::setEmail(const QString& email)
{
    if (m_email != email) {
        m_email = email;
        emit emailChanged();
    }
}

void User::setFirstName(const QString& name)
{
    if (m_firstName != name) {
        m_firstName = name;
        emit firstNameChanged();
    }
}

void User::setLastName(const QString& name)
{
    if (m_lastName != name) {
        m_lastName = name;
        emit lastNameChanged();
    }
}

void User::setOptedIn(bool optedIn)
{
    if (m_optedIn == optedIn)
        return;

    m_optedIn = optedIn;
    emit optedInChanged();
}

void User::setPassword(const QByteArray& password)
{
    if (m_password != password) {
        m_password = password;
        emit passwordChanged();
    }
}

void User::clear()
{
    setEmail(QString());
    setPassword(QByteArray());
    setFirstName(QString());
    setLastName(QString());
    setVillage(QString());
    setOptedIn(false);
}

const QString &User::phone() const
{
    return m_phone;
}

void User::setPhone(const QString &newPhone)
{
    if (m_phone == newPhone)
        return;
    m_phone = newPhone;
    emit phoneChanged();
}

const QString &User::village() const
{
    return m_village;
}

void User::setVillage(const QString &newVillage)
{
    if (m_village == newVillage)
        return;
    m_village = newVillage;
    emit villageChanged();
}
