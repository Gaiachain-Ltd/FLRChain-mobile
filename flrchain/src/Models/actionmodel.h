#ifndef ACTIONMODEL_H
#define ACTIONMODEL_H

#include <QAbstractListModel>

#include "types.h"

class ActionModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles
    {
        ActionIdRole = Qt::UserRole,
        ActionNameRole,
        ActionMilestonesRole
    };

    explicit ActionModel(QObject *parent = nullptr);

    QHash<int, QByteArray> roleNames() const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;

    void reload(const ActionList &actions);

private:
    ActionList m_actions;
};

Q_DECLARE_METATYPE(ActionModel*)

#endif // ACTIONMODEL_H
