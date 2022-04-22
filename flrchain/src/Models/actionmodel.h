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

#ifndef ACTIONMODEL_H
#define ACTIONMODEL_H

#include <QAbstractListModel>

#include "types.h"

class ActionModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)
    Q_PROPERTY(bool hasFavouriteTask READ hasFavouriteTask NOTIFY hasFavouriteTaskChanged)

public:
    enum Roles
    {
        ActionIdRole = Qt::UserRole,
        ActionNameRole,
        ActionMilestonesRole,
        ActionHasFavouriteTaskRole
    };

    explicit ActionModel(QObject *parent = nullptr);

    QHash<int, QByteArray> roleNames() const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;

    const ActionList &actions() const;
    void reload(const ActionList &actions);
    bool hasFavouriteTask() const;

signals:
    void countChanged();
    void hasFavouriteTaskChanged();

private slots:
    void onActionHasFavouriteTaskChanged();

private:
    int indexOfActionWithId(const int id) const;

    ActionList m_actions;
};

Q_DECLARE_METATYPE(ActionModel*)

#endif // ACTIONMODEL_H
