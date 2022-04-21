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

#ifndef MILESTONE_H
#define MILESTONE_H

#include <QObject>
#include <QScopedPointer>

#include "types.h"
#include "taskmodel.h"

class Milestone : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(TaskModel* tasks READ tasks CONSTANT)
    Q_PROPERTY(bool hasFavouriteTask READ hasFavouriteTask NOTIFY hasFavouriteTaskChanged)

public:
    explicit Milestone(const int id,
                       const QString &name,
                       const TaskList &tasks,
                       QObject *parent = nullptr);

    int id() const;
    QString name() const;
    void setName(const QString &name);
    TaskModel* tasks() const;
    void reloadTasks(const TaskList &tasks);
    bool hasFavouriteTask() const;

    static MilestonePtr createFromJson(const QJsonObject &milestoneObject);

signals:
    void nameChanged(const QString &name);
    void hasFavouriteTaskChanged();

private:
    int m_id;
    QString m_name;
    QScopedPointer<TaskModel> m_tasks;
};

Q_DECLARE_METATYPE(Milestone*)
Q_DECLARE_METATYPE(MilestonePtr)
Q_DECLARE_METATYPE(MilestoneList)

#endif // MILESTONE_H
