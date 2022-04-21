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

#ifndef TASK_H
#define TASK_H

#include <QObject>
#include <QScopedPointer>

#include "types.h"
#include "datatagmodel.h"

class Task : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(qreal reward READ reward WRITE setReward NOTIFY rewardChanged)
    Q_PROPERTY(qreal batch READ batch WRITE setBatch NOTIFY batchChanged)
    Q_PROPERTY(bool finished READ finished WRITE setFinished NOTIFY finishedChanged)
    Q_PROPERTY(bool favourite READ favourite WRITE setFavourite NOTIFY favouriteChanged)
    Q_PROPERTY(QString instructions READ instructions WRITE setInstructions NOTIFY instructionsChanged)
    Q_PROPERTY(QString dataTypeTag READ dataTypeTag WRITE setDataTypeTag NOTIFY dataTypeTagChanged)
    Q_PROPERTY(DataTagModel* dataTags READ dataTags CONSTANT)
    Q_PROPERTY(int projectId READ projectId CONSTANT)
    Q_PROPERTY(QString projectName READ projectName WRITE setProjectName NOTIFY projectNameChanged)
    Q_PROPERTY(int actionId READ actionId CONSTANT)
    Q_PROPERTY(QString actionName READ actionName WRITE setActionName NOTIFY actionNameChanged)
    Q_PROPERTY(int milestoneId READ milestoneId CONSTANT)
    Q_PROPERTY(QString milestoneName READ milestoneName WRITE setMilestoneName NOTIFY milestoneNameChanged)

public:
    explicit Task(const int id,
                  const QString &name,
                  const qreal reward,
                  const qreal batch,
                  const bool finished,
                  const QString &instructions,
                  const QString &dataTypeTag,
                  const DataTagList &dataTags,
                  const int projectId,
                  const QString &projectName,
                  const int actionId,
                  const QString &actionName,
                  const int milestoneId,
                  const QString &milestoneName,
                  QObject *parent = nullptr);

    int id() const;
    QString name() const;
    void setName(const QString &name);
    qreal reward() const;
    void setReward(const qreal reward);
    qreal batch() const;
    void setBatch(const qreal batch);
    bool finished() const;
    void setFinished(const bool finished);
    bool favourite() const;
    void setFavourite(const bool favourite);
    QString instructions() const;
    void setInstructions(const QString &instructions);
    QString dataTypeTag() const;
    void setDataTypeTag(const QString &dataTypeTag);
    DataTagModel* dataTags() const;
    void reloadDataTags(const DataTagList &dataTags);
    int projectId() const;
    QString projectName() const;
    void setProjectName(const QString &projectName);
    int actionId() const;
    QString actionName() const;
    void setActionName(const QString &actionName);
    int milestoneId() const;
    QString milestoneName() const;
    void setMilestoneName(const QString &milestoneName);

    static TaskPtr createFromJson(const QJsonObject &taskObject);
    static TaskPtr emptyTask();

signals:
    void nameChanged(const QString &action);
    void rewardChanged(const qreal reward);
    void batchChanged(const qreal batch);
    void finishedChanged(const bool finished);
    void favouriteChanged(const bool favourite);
    void instructionsChanged(const QString &instructions);
    void dataTypeTagChanged(const QString &dataTypeTag);
    void projectNameChanged(const QString &projectName);
    void actionNameChanged(const QString &actionName);
    void milestoneNameChanged(const QString &milestoneName);

private:
    int m_id;
    QString m_name;
    qreal m_reward;
    qreal m_batch;
    bool m_finished;
    QString m_instructions;
    QString m_dataTypeTag;
    QScopedPointer<DataTagModel> m_dataTags;
    int m_projectId;
    QString m_projectName;
    int m_actionId;
    QString m_actionName;
    int m_milestoneId;
    QString m_milestoneName;
};

Q_DECLARE_METATYPE(Task*)
Q_DECLARE_METATYPE(TaskPtr)
Q_DECLARE_METATYPE(TaskList)

#endif // TASK_H
