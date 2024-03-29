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

#ifndef TRANSACTION_H
#define TRANSACTION_H
#include <QObject>
#include <QVariantList>
#include <QVariant>

class Transaction : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(int action READ action WRITE setAction NOTIFY actionChanged)
    Q_PROPERTY(double amount READ amount WRITE setAmount NOTIFY amountChanged)
    Q_PROPERTY(QString creationDate READ creationDate WRITE setCreationDate NOTIFY creationDateChanged)
    Q_PROPERTY(int status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(QString note READ note WRITE setNote NOTIFY noteChanged)

public:
    Transaction(QObject *parent = nullptr);

    int id() const;
    QString title() const;
    int action() const;
    double amount() const;
    QString creationDate() const;
    int status() const;
    const QString &note() const;

public slots:
    void setId(const int id);
    void setTitle(const QString &title);
    void setAction(const int action);
    void setAmount(const double amount);
    void setCreationDate(const QString &creationDate);
    void setStatus(int status);
    void setNote(const QString &newNote);

signals:
    void idChanged(int id);
    void titleChanged(QString title);
    void actionChanged(int action);
    void amountChanged(double amount);
    void creationDateChanged(QString creationDate);
    void statusChanged(int status);
    void noteChanged(QString node);

private:
    int m_id;
    QString m_title;
    int m_action;
    double m_amount;
    QString m_creationDate;
    int m_status;
    QString m_note;
};

#endif // PROJECT_H
