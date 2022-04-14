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

#ifndef DATATAG_H
#define DATATAG_H

#include <QObject>

#include "types.h"

class DataTag : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(QString name READ name CONSTANT)
    Q_PROPERTY(Type type READ type CONSTANT)
    Q_PROPERTY(QString unit READ unit CONSTANT)

public:
    enum class Type : int
    {
        Text,
        Number,
        Area,
        Photo
    };
    Q_ENUM(Type)

    explicit DataTag(const int id,
                     const QString &name,
                     const Type type,
                     const QString &unit,
                     QObject *parent = nullptr);

    int id() const;
    QString name() const;
    Type type() const;
    QString unit() const;

    static DataTagPtr createFromJson(const QJsonObject &dataTagObject);

private:
    int m_id;
    QString m_name;
    Type m_type;
    QString m_unit;
};

Q_DECLARE_METATYPE(DataTag*)
Q_DECLARE_METATYPE(DataTagPtr)
Q_DECLARE_METATYPE(DataTagList)

#endif // DATATAG_H
