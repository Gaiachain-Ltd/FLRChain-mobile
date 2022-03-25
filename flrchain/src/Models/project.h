#ifndef PROJECT_H
#define PROJECT_H

#include <QObject>
#include <QVariantList>
#include <QVariant>
#include "task.h"

class Project : public QObject
{
    Q_OBJECT
    Q_CLASSINFO("RegisterEnumClassesUnscoped", "false")

    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)
    Q_PROPERTY(ProjectStatus status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(QString deadline READ deadline WRITE setDeadline NOTIFY deadlineChanged)
    Q_PROPERTY(QString investmentStart READ investmentStart WRITE setInvestmentStart NOTIFY investmentStartChanged)
    Q_PROPERTY(QString investmentEnd READ investmentEnd WRITE setInvestmentEnd NOTIFY investmentEndChanged)
    Q_PROPERTY(QString photo READ photo WRITE setPhoto NOTIFY photoChanged)
    Q_PROPERTY(QList<Task *> tasks READ tasks WRITE setTasks NOTIFY tasksChanged)
    Q_PROPERTY(AssignmentStatus assignmentStatus READ assignmentStatus WRITE setAssignmentStatus NOTIFY assignmentStatusChanged)
    Q_PROPERTY(bool confirmed READ confirmed WRITE setConfirmed NOTIFY confirmedChanged)

public:
    Project(QObject *parent = nullptr);

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

    int id() const;
    QString name() const;
    QString description() const;
    ProjectStatus status() const;
    QString deadline() const;
    QString investmentStart() const;
    QString investmentEnd() const;
    QString photo() const;
    QList<Task *> tasks() const;
    AssignmentStatus assignmentStatus() const;
    bool confirmed() const;

public slots:
    void setId(const int id);
    void setName(const QString &name);
    void setDescription(const QString &description);
    void setStatus(const ProjectStatus status);
    void setDeadline(const QString &deadline);
    void setInvestmentStart(const QString &investmentStart);
    void setInvestmentEnd(const QString &investmentEnd);
    void setPhoto(const QString &photo);
    void setTasks(const QList<Task *> &tasks);
    void setAssignmentStatus(const AssignmentStatus status);
    void setConfirmed(bool confirmed);

signals:
    void idChanged(int id);
    void nameChanged(QString name);
    void descriptionChanged(QString description);
    void statusChanged(ProjectStatus status);
    void deadlineChanged(QString deadline);
    void investmentStartChanged(QString investmentStart);
    void investmentEndChanged(QString investmentEnd);
    void photoChanged(QString photo);
    void tasksChanged(QList<Task *> tasks);
    void assignmentStatusChanged(AssignmentStatus status);
    void confirmedChanged(bool confirmed);

private:
    int m_id;
    QString m_name;
    QString m_description;
    ProjectStatus m_status;
    QString m_deadline;
    QString m_investmentStart;
    QString m_investmentEnd;
    QString m_photo;
    QList<Task *> m_tasks;
    AssignmentStatus m_assignmentStatus;
    bool m_confirmed;
};

#endif // PROJECT_H
