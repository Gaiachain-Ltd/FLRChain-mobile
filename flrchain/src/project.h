#ifndef PROJECT_H
#define PROJECT_H
#include <QObject>
#include <QVariantList>
#include <QVariant>

class Project : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)
    Q_PROPERTY(QString status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(QString deadline READ deadline WRITE setDeadline NOTIFY deadlineChanged)
    Q_PROPERTY(QString investmentStart READ investmentStart WRITE setInvestmentStart NOTIFY investmentStartChanged)
    Q_PROPERTY(QString investmentEnd READ investmentEnd WRITE setInvestmentEnd NOTIFY investmentEndChanged)
    Q_PROPERTY(QString photo READ photo WRITE setPhoto NOTIFY photoChanged)
    Q_PROPERTY(QVariantList tasks READ tasks WRITE setTasks NOTIFY tasksChanged)
    Q_PROPERTY(int assignmentStatus READ assignmentStatus WRITE setAssignmentStatus NOTIFY assignmentStatusChanged)

public:
    Project(QObject *parent = nullptr);

    enum AssignmentStatus {
        Undefined = -1,
        Rejected = 0,
        Joined = 1,
        Pending = 2
    }; // enum AssignmentStatus

    Q_ENUM(AssignmentStatus)

    int id() const;
    QString name() const;
    QString description() const;
    QString status() const;
    QString deadline() const;
    QString investmentStart() const;
    QString investmentEnd() const;
    QString photo() const;
    QVariantList tasks() const;
    int assignmentStatus() const;

public slots:
    void setId(const int id);
    void setName(const QString &name);
    void setDescription(const QString &description);
    void setStatus(const QString &status);
    void setDeadline(const QString &deadline);
    void setInvestmentStart(const QString &investmentStart);
    void setInvestmentEnd(const QString &investmentEnd);
    void setPhoto(const QString &photo);
    void setTasks(const QVariantList &tasks);
    void setAssignmentStatus(const int status);

signals:
    void idChanged(int id);
    void nameChanged(QString name);
    void descriptionChanged(QString description);
    void statusChanged(QString status);
    void deadlineChanged(QString deadline);
    void investmentStartChanged(QString investmentStart);
    void investmentEndChanged(QString investmentEnd);
    void photoChanged(QString photo);
    void tasksChanged(QVariantList tasks);
    void assignmentStatusChanged(int status);

private:
    int m_id;
    QString m_name;
    QString m_description;
    QString m_status;
    QString m_deadline;
    QString m_investmentStart;
    QString m_investmentEnd;
    QString m_photo;
    QVariantList m_tasks;
    int m_assignmentStatus;
};

#endif // PROJECT_H
