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
    Q_PROPERTY(QString dataTypeTag READ dataTypeTag WRITE setDataTypeTag NOTIFY dataTypeTagChanged)
    Q_PROPERTY(int projectId READ projectId CONSTANT)
    Q_PROPERTY(DataTagModel* dataTags READ dataTags CONSTANT)

public:
    explicit Task(const int id,
                  const QString &name,
                  const qreal reward,
                  const qreal batch,
                  const bool finished,
                  const QString &dataTypeTag,
                  const int projectId,
                  const DataTagList &dataTags,
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
    QString dataTypeTag() const;
    void setDataTypeTag(const QString &dataTypeTag);
    int projectId() const;
    DataTagModel* dataTags() const;
    void reloadDataTags(const DataTagList &dataTags);

    static TaskPtr createFromJson(const QJsonObject &taskObject);

signals:
    void nameChanged(const QString &action);
    void rewardChanged(const qreal reward);
    void batchChanged(const qreal batch);
    void finishedChanged(const bool finished);
    void dataTypeTagChanged(const QString &dataTypeTag);

private:
    int m_id;
    QString m_name;
    qreal m_reward;
    qreal m_batch;
    bool m_finished;
    QString m_dataTypeTag;
    int m_projectId;
    QScopedPointer<DataTagModel> m_dataTags;
};

Q_DECLARE_METATYPE(Task*)
Q_DECLARE_METATYPE(TaskPtr)
Q_DECLARE_METATYPE(TaskList)

#endif // TASK_H
