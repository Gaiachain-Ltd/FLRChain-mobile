#ifndef MILESTONEMODEL_H
#define MILESTONEMODEL_H

#include <QAbstractListModel>

#include "types.h"

class MilestoneModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)
    Q_PROPERTY(bool hasFavouriteTask READ hasFavouriteTask NOTIFY hasFavouriteTaskChanged)

public:
    enum Roles
    {
        MilestoneIdRole = Qt::UserRole,
        MilestoneNameRole,
        MilestoneTasksRole,
        MilestoneHasFavouriteTaskRole
    };

    explicit MilestoneModel(QObject *parent = nullptr);

    QHash<int, QByteArray> roleNames() const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;

    void reload(const MilestoneList &milestones);
    bool hasFavouriteTask() const;

signals:
    void countChanged();
    void hasFavouriteTaskChanged();

private:
    MilestoneList m_milestones;
};

Q_DECLARE_METATYPE(MilestoneModel*)

#endif // MILESTONEMODEL_H
