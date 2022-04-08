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

#ifndef PROJECT_H
#define PROJECT_H

#include <QObject>
#include <QUrl>
#include <QDate>

#include "types.h"
#include "actionmodel.h"

class Project : public QObject
{
    Q_OBJECT
    Q_CLASSINFO("RegisterEnumClassesUnscoped", "false")

    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged) // API field: title
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)
    Q_PROPERTY(QString photo READ photo WRITE setPhoto NOTIFY photoChanged) // API field: image
    Q_PROPERTY(QUrl mapLink READ mapLink WRITE setMapLink NOTIFY mapLinkChanged) // API field: maplink
    Q_PROPERTY(ProjectStatus status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(QDate startDate READ startDate WRITE setStartDate NOTIFY startDateChanged) // API field: start
    Q_PROPERTY(QDate endDate READ endDate WRITE setEndDate NOTIFY endDateChanged) // API field: end
    Q_PROPERTY(AssignmentStatus assignmentStatus READ assignmentStatus WRITE setAssignmentStatus NOTIFY assignmentStatusChanged)
    Q_PROPERTY(ActionModel* actions READ actions CONSTANT)

public:
    enum class AssignmentStatus : int {
        Undefined = -2,
        New = -1,
        Waiting = 0,
        Accepted = 1,
        Rejected = 2
    };
    Q_ENUM(AssignmentStatus)

    enum class ProjectStatus : int {
        Undefined = 0,
        Fundraising = 1,
        Active = 2,
        Closed = 3
    };
    Q_ENUM(ProjectStatus)

    explicit Project(const int id,
                     const QString &name,
                     const QString &description,
                     const QString &photo,
                     const QUrl &mapLink,
                     const ProjectStatus status,
                     const QDate &startDate,
                     const QDate &endDate,
                     const AssignmentStatus assignmentStatus,
                     const ActionList &actions,
                     QObject *parent = nullptr);

    int id() const;
    QString name() const;
    void setName(const QString &name);
    QString description() const;
    void setDescription(const QString &description);
    QString photo() const;
    void setPhoto(const QString &photo);
    QUrl mapLink() const;
    void setMapLink(const QUrl &mapLink);
    ProjectStatus status() const;
    void setStatus(const ProjectStatus status);
    QDate startDate() const;
    void setStartDate(const QDate &startDate);
    QDate endDate() const;
    void setEndDate(const QDate &endDate);
    AssignmentStatus assignmentStatus() const;
    void setAssignmentStatus(const AssignmentStatus status);
    ActionModel* actions() const;
    void reloadActions(const ActionList &actions);

    static ProjectPtr parseJson(const QJsonObject &projectObject, ProjectPtr project = Q_NULLPTR);
    static ProjectPtr createFromJson(const QJsonObject& projectObject);
    static ProjectPtr updateFromJson(const QJsonObject &projectObject, ProjectPtr project);
    static ProjectPtr emptyProject();

signals:
    void nameChanged(const QString &name);
    void descriptionChanged(const QString &description);
    void photoChanged(const QString &photo);
    void mapLinkChanged(const QUrl &mapLink);
    void statusChanged(const ProjectStatus status);
    void startDateChanged(const QDate &startDate);
    void endDateChanged(const QDate &endDate);
    void assignmentStatusChanged(const AssignmentStatus status);

private:
    int m_id;
    QString m_name;
    QString m_description;
    QString m_photo;
    QUrl m_mapLink;
    ProjectStatus m_status;
    QDate m_startDate;
    QDate m_endDate;
    AssignmentStatus m_assignmentStatus;
    QScopedPointer<ActionModel> m_actions;
};

Q_DECLARE_METATYPE(Project*)
Q_DECLARE_METATYPE(ProjectPtr)
Q_DECLARE_METATYPE(ProjectList)

#endif // PROJECT_H
