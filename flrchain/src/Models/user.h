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

#ifndef USER_H
#define USER_H

#include <QObject>
#include <QByteArray>
#include <QString>

class User : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString phone READ phone WRITE setPhone NOTIFY phoneChanged)
    Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged)
    Q_PROPERTY(QString firstName READ firstName WRITE setFirstName NOTIFY firstNameChanged)
    Q_PROPERTY(QString lastName READ lastName WRITE setLastName NOTIFY lastNameChanged)
    Q_PROPERTY(QString village READ village WRITE setVillage NOTIFY villageChanged)
    Q_PROPERTY(bool optedIn READ optedIn WRITE setOptedIn NOTIFY optedInChanged)
public:
    User(QObject *parent = nullptr);

    QString email() const;
    QString firstName() const;
    QString lastName() const;
    bool optedIn() const;
    QByteArray password() const;
    const QString &phone() const;
    const QString &village() const;

    void setEmail(const QString& email);
    void setFirstName(const QString& name);
    void setLastName(const QString& name);
    void setPassword(const QByteArray& password);
    void setOptedIn(bool optedIn);
    void setPhone(const QString &newPhone);
    void setVillage(const QString &newVillage);

    void clear();

signals:
    void emailChanged();
    void firstNameChanged();
    void lastNameChanged();
    void phoneChanged();
    void passwordChanged();
    void optedInChanged();

    void villageChanged();

private:
    QString m_email;
    QByteArray m_password;
    QString m_firstName;
    QString m_lastName;
    QString m_phone;
    QString m_village;
    bool m_optedIn;
};

#endif // USER_H
