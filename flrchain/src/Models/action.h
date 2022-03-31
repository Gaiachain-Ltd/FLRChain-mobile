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

#ifndef ACTION_H
#define ACTION_H

#include <QObject>
#include <QScopedPointer>

#include "types.h"
#include "milestonemodel.h"

class Action : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(MilestoneModel* milestones READ milestones CONSTANT)
    Q_PROPERTY(bool hasFavouriteTask READ hasFavouriteTask NOTIFY hasFavouriteTaskChanged)

public:
    explicit Action(const int id,
                    const QString &name,
                    const MilestoneList &milestones,
                    QObject *parent = nullptr);

    int id() const;
    QString name() const;
    void setName(const QString &name);
    MilestoneModel* milestones() const;
    void reloadMilestones(const MilestoneList &milestones);
    bool hasFavouriteTask() const;

    static ActionPtr createFromJson(const QJsonObject &actionObject);

signals:
    void nameChanged(const QString &name);
    void hasFavouriteTaskChanged();

private:
    int m_id;
    QString m_name;
    QScopedPointer<MilestoneModel> m_milestones;
};

Q_DECLARE_METATYPE(Action*)
Q_DECLARE_METATYPE(ActionPtr)
Q_DECLARE_METATYPE(ActionList)

#endif // ACTION_H
