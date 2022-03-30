#ifndef TASKMODEL_H
#define TASKMODEL_H

#include <QAbstractListModel>

#include "types.h"

class TaskModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)
    Q_PROPERTY(bool hasFavouriteTask READ hasFavouriteTask NOTIFY hasFavouriteTaskChanged)

public:
    enum Roles
    {
        TaskIdRole = Qt::UserRole,
        TaskNameRole,
        TaskRewardRole,
        TaskBatchRole,
        TaskFinishedRole,
        TaskFavouriteRole,
        TaskDataTypeTagRole,
        TaskDataTagsRole
    };

    explicit TaskModel(QObject *parent = nullptr);

    QHash<int, QByteArray> roleNames() const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;

    void reload(const TaskList &tasks);
    bool hasFavouriteTask() const;

signals:
    void countChanged();
    void hasFavouriteTaskChanged();

private:
    TaskList m_tasks;
};

Q_DECLARE_METATYPE(TaskModel*)

#endif // TASKMODEL_H
