#ifndef MILESTONEMODEL_H
#define MILESTONEMODEL_H

#include <QAbstractListModel>

#include "types.h"

class MilestoneModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles
    {
        MilestoneIdRole = Qt::UserRole,
        MilestoneNameRole,
        MilestoneTasksRole
    };

    explicit MilestoneModel(QObject *parent = nullptr);

    QHash<int, QByteArray> roleNames() const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;

    void reload(const MilestoneList &milestones);

private:
    MilestoneList m_milestones;
};

Q_DECLARE_METATYPE(MilestoneModel*)

#endif // MILESTONEMODEL_H
