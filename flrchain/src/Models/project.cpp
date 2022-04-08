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

#include "project.h"
#include "action.h"

#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>

Project::Project(const int id,
                 const QString &name,
                 const QString &description,
                 const QString &photo,
                 const QUrl &mapLink,
                 const ProjectStatus status,
                 const QDate &startDate,
                 const QDate &endDate,
                 const AssignmentStatus assignmentStatus,
                 const ActionList &actions,
                 QObject *parent)
    : QObject(parent)
    , m_id(id)
    , m_name(name)
    , m_description(description)
    , m_photo(photo)
    , m_mapLink(mapLink)
    , m_status(status)
    , m_startDate(startDate)
    , m_endDate(endDate)
    , m_assignmentStatus(assignmentStatus)
    , m_actions(new ActionModel)
{
    reloadActions(actions);
}

int Project::id() const
{
    return m_id;
}

QString Project::name() const
{
    return m_name;
}

void Project::setName(const QString &name)
{
    if (m_name != name) {
        m_name = name;
        emit nameChanged(name);
    }
}

QString Project::description() const
{
    return m_description;
}

void Project::setDescription(const QString &description)
{
    if (m_description != description) {
        m_description = description;
        emit descriptionChanged(description);
    }
}

QString Project::photo() const
{
    return m_photo;
}

void Project::setPhoto(const QString &photo)
{
    if (m_photo != photo) {
        m_photo = photo;
        emit photoChanged(photo);
    }
}

QUrl Project::mapLink() const
{
    return m_mapLink;
}

void Project::setMapLink(const QUrl &mapLink)
{
    if (mapLink != m_mapLink) {
        m_mapLink = mapLink;
        emit mapLinkChanged(mapLink);
    }
}

Project::ProjectStatus Project::status() const
{
    return m_status;
}

void Project::setStatus(const ProjectStatus status)
{
    if (m_status != status) {
        m_status = status;
        emit statusChanged(status);
    }
}

QDate Project::startDate() const
{
    return m_startDate;
}

void Project::setStartDate(const QDate &startDate)
{
    if (m_startDate != startDate) {
        m_startDate = startDate;
        emit startDateChanged(startDate);
    }
}

QDate Project::endDate() const
{
    return m_endDate;
}

void Project::setEndDate(const QDate &endDate)
{
    if (m_endDate != endDate) {
        m_endDate = endDate;
        emit endDateChanged(endDate);
    }
}

Project::AssignmentStatus Project::assignmentStatus() const
{
    return m_assignmentStatus;
}

void Project::setAssignmentStatus(const AssignmentStatus status)
{
    if (m_assignmentStatus != status) {
        m_assignmentStatus = status;
        emit assignmentStatusChanged(status);
    }
}

ActionModel *Project::actions() const
{
    return m_actions.get();
}

void Project::reloadActions(const ActionList &actions)
{
    m_actions->reload(actions);
}


ProjectPtr Project::parseJson(const QJsonObject &projectObject, ProjectPtr project)
{
    const int projectId = projectObject.value(u"id").toInt();
    const QString projectName = projectObject.value(u"title").toString();
    const QString projectDescription = projectObject.value(u"description").toString();
    const QString projectPhoto = projectObject.value(u"image").toString();
    const QUrl projectMapLink = projectObject.value(u"maplink").toString();
    const Project::ProjectStatus projectStatus =
            static_cast<Project::ProjectStatus>(projectObject.value(u"status").toInt());
    const QDate projectStartDate = QDate::fromString(projectObject.value(u"start").toString(), QStringLiteral("yyyy-MM-dd"));
    const QDate projectEndDate = QDate::fromString(projectObject.value(u"end").toString(), QStringLiteral("yyyy-MM-dd"));

    Project::AssignmentStatus projectAssignmentStatus;
    if (projectObject.value(QLatin1String("assignment_status")).isNull()) {
        projectAssignmentStatus = Project::AssignmentStatus::New;
    } else {
        projectAssignmentStatus = static_cast<Project::AssignmentStatus>(projectObject.value(QLatin1String("assignment_status")).toInt());
    }

    ActionList projectActions;
    const QJsonArray actionsArray = projectObject.value(u"actions").toArray();

    for (const QJsonValue &value : actionsArray) {
        const QJsonObject actionObject = value.toObject();
        const ActionPtr &action = Action::createFromJson(actionObject);
        projectActions.append(action);
    }

    if (project.isNull()) {
        return ProjectPtr::create(projectId,
                                  projectName,
                                  projectDescription,
                                  projectPhoto,
                                  projectMapLink,
                                  projectStatus,
                                  projectStartDate,
                                  projectEndDate,
                                  projectAssignmentStatus,
                                  projectActions);
    } else {
        project->setName(projectName);
        project->setDescription(projectDescription);
        project->setPhoto(projectPhoto);
        project->setMapLink(projectMapLink);
        project->setStatus(projectStatus);
        project->setStartDate(projectStartDate);
        project->setEndDate(projectEndDate);
        project->setAssignmentStatus(projectAssignmentStatus);
        project->reloadActions(projectActions);
        return project;
    }
}

ProjectPtr Project::createFromJson(const QJsonObject &projectObject)
{
    return Project::parseJson(projectObject);
}

ProjectPtr Project::updateFromJson(const QJsonObject &projectObject, ProjectPtr project)
{
    return Project::parseJson(projectObject, project);
}

ProjectPtr Project::emptyProject()
{
    return ProjectPtr::create(-1, QString(), QString(), QString(), QUrl(), Project::ProjectStatus::Undefined,
                              QDate(), QDate(), Project::AssignmentStatus::Undefined, ActionList());
}
