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

#include "projectmodel.h"
#include "project.h"

#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

ProjectModel::ProjectModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_projects()
{

}

int ProjectModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_projects.length();
}

QHash<int, QByteArray> ProjectModel::roleNames() const
{
    static const QHash<int, QByteArray> ROLE_NAMES = {
        { ProjectIdRole, QByteArrayLiteral("projectId") },
        { ProjectNameRole, QByteArrayLiteral("projectName") },
        { ProjectDescriptionRole, QByteArrayLiteral("projectDescription") },
        { ProjectPhotoRole, QByteArrayLiteral("projectPhoto") },
        { ProjectMapLinkRole, QByteArrayLiteral("projectMapLink") },
        { ProjectStatusRole, QByteArrayLiteral("projectStatus") },
        { ProjectStartDateRole, QByteArrayLiteral("projectStartDate") },
        { ProjectEndDateRole, QByteArrayLiteral("projectEndDate") },
        { ProjectAssignmentStatusRole, QByteArrayLiteral("projectAssignmentStatus") },
        { ProjectActionsRole, QByteArrayLiteral("projectActions") }
    };

    return ROLE_NAMES;
}

QVariant ProjectModel::data(const QModelIndex &index, int role) const
{
    const int row = index.row();

    if (role < Qt::UserRole || row < 0 || row >= m_projects.length())
         return QVariant();

    const ProjectPtr &project = m_projects[row];

    switch (role)
    {
        case ProjectIdRole:
            return project->id();

        case ProjectNameRole:
            return project->name();

        case ProjectDescriptionRole:
            return project->description();

        case ProjectPhotoRole:
            return project->photo();

        case ProjectMapLinkRole:
            return project->mapLink();

        case ProjectStatusRole:
            return static_cast<int>(project->status());

        case ProjectStartDateRole:
            return project->startDate();

        case ProjectEndDateRole:
            return project->endDate();

        case ProjectAssignmentStatusRole:
            return static_cast<int>(project->assignmentStatus());

        case ProjectActionsRole:
            return QVariant::fromValue(project->actions());
    }

    qWarning() << "Unsupported model role:" << role;

    return QVariant();
}

bool ProjectModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    const int row = index.row();

    if (role < Qt::UserRole || row < 0 || row >= m_projects.length())
         return false;

    ProjectPtr &project = m_projects[row];
    bool modified = false;

    switch (role)
    {
        case ProjectNameRole:
            project->setName(value.toString());
            modified = true;
            break;

        case ProjectDescriptionRole:
            project->setDescription(value.toString());
            modified = true;
            break;

        case ProjectPhotoRole:
            project->setPhoto(value.toString());
            modified = true;
            break;

        case ProjectMapLinkRole:
            project->setMapLink(value.toUrl());
            modified = true;
            break;

        case ProjectStatusRole:
            project->setStatus(static_cast<Project::ProjectStatus>(value.toInt()));
            modified = true;
            break;

        case ProjectStartDateRole:
            project->setStartDate(value.toDate());
            modified = true;
            break;

        case ProjectEndDateRole:
            project->setEndDate(value.toDate());
            modified = true;
            break;

        case ProjectAssignmentStatusRole:
            project->setAssignmentStatus(static_cast<Project::AssignmentStatus>(value.toInt()));
            modified = true;
            break;

        case ProjectIdRole:
        case ProjectActionsRole:
            qWarning() << "Trying to use role that is not editable:" << role;
            break;
    }

    if (modified) {
        emit dataChanged(index, index, {role});
        return true;
    }

    return false;
}

void ProjectModel::reloadFromJson(const QJsonObject &response)
{
    beginResetModel();
    {
        m_projects.clear();

        const QJsonArray projectsArray = response.value(QLatin1String("results")).toArray();

        for (const QJsonValue &value : projectsArray) {
            const QJsonObject projectObject = value.toObject();
            const ProjectPtr &project = Project::createFromJson(projectObject);
            m_projects.append(project);
        }

        emit projectsReceived();
    }
    endResetModel();
}

void ProjectModel::clear()
{
    beginResetModel();
    m_projects.clear();
    endResetModel();
}

ProjectPtr ProjectModel::projectWithId(const int id) const
{
    auto it = std::find_if(m_projects.constBegin(), m_projects.constEnd(), [&](const ProjectPtr &project){
        return project->id() == id;
    });

    if (it != m_projects.constEnd()) {
        return *it;
    }

    return Project::emptyProject();
}
