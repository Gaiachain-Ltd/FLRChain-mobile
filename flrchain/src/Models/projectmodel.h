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

#ifndef PROJECTMODEL_H
#define PROJECTMODEL_H

#include <QAbstractListModel>

#include "types.h"

class ProjectModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum ModelRole
    {
        ProjectIdRole = Qt::UserRole,
        ProjectNameRole,
        ProjectDescriptionRole,
        ProjectPhotoRole,
        ProjectMapLinkRole,
        ProjectStatusRole,
        ProjectStartDateRole,
        ProjectEndDateRole,
        ProjectAssignmentStatusRole,
        ProjectActionsRole
    };

    explicit ProjectModel(QObject *parent = nullptr);

    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    void clear();

    ProjectPtr projectWithId(const int id) const;

public slots:
    void reloadFromJson(const QJsonObject &response);

signals:
    void projectsReceived();

private:
    ProjectList m_projects;
};

#endif // PROJECTMODEL_H
