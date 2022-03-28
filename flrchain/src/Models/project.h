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
    Q_PROPERTY(QUrl photo READ photo WRITE setPhoto NOTIFY photoChanged) // API field: image
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
                     const QUrl &photo,
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
    QUrl photo() const;
    void setPhoto(const QUrl &photo);
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

    static ProjectPtr createFromJson(const QJsonObject& projectObject);
    static ProjectPtr emptyProject();

signals:
    void nameChanged(const QString &name);
    void descriptionChanged(const QString &description);
    void photoChanged(const QUrl &photo);
    void statusChanged(const ProjectStatus status);
    void startDateChanged(const QDate &startDate);
    void endDateChanged(const QDate &endDate);
    void assignmentStatusChanged(const AssignmentStatus status);

private:
    int m_id;
    QString m_name;
    QString m_description;
    QUrl m_photo;
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
