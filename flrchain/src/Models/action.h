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

    static ActionPtr createFromJson(const QJsonObject &actionObject);

signals:
    void nameChanged(const QString &name);

private:
    int m_id;
    QString m_name;
    QScopedPointer<MilestoneModel> m_milestones;
};

Q_DECLARE_METATYPE(Action*)
Q_DECLARE_METATYPE(ActionPtr)
Q_DECLARE_METATYPE(ActionList)

#endif // ACTION_H
