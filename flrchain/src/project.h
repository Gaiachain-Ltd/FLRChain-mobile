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
    Q_PROPERTY(bool joined READ joined WRITE setJoined NOTIFY joinedChanged)
    Q_PROPERTY(QString status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(QString deadline READ deadline WRITE setDeadline NOTIFY deadlineChanged)
    Q_PROPERTY(QString investmentStart READ investmentStart WRITE setInvestmentStart NOTIFY investmentStartChanged)
    Q_PROPERTY(QString investmentEnd READ investmentEnd WRITE setInvestmentEnd NOTIFY investmentEndChanged)
    Q_PROPERTY(QString photo READ photo WRITE setPhoto NOTIFY photoChanged)
    Q_PROPERTY(QVariantList tasks READ tasks WRITE setTasks NOTIFY tasksChanged)

public:
    Project(QObject *parent = nullptr);

    int id() const;
    QString name() const;
    QString description() const;
    bool joined() const;
    QString status() const;
    QString deadline() const;
    QString investmentStart() const;
    QString investmentEnd() const;
    QString photo() const;
    QVariantList tasks() const;

public slots:
    void setId(const int id);
    void setName(const QString &name);
    void setDescription(const QString &description);
    void setJoined(const bool joined);
    void setStatus(const QString &status);
    void setDeadline(const QString &deadline);
    void setInvestmentStart(const QString &investmentStart);
    void setInvestmentEnd(const QString &investmentEnd);
    void setPhoto(const QString &photo);
    void setTasks(const QVariantList &tasks);

signals:
    void idChanged(int id);
    void nameChanged(QString name);
    void descriptionChanged(QString description);
    void joinedChanged(bool joined);
    void statusChanged(QString status);
    void deadlineChanged(QString deadline);
    void investmentStartChanged(QString investmentStart);
    void investmentEndChanged(QString investmentEnd);
    void photoChanged(QString photo);
    void tasksChanged(QVariantList tasks);

private:
    int m_id;
    QString m_name;
    QString m_description;
    bool m_joined;
    QString m_status;
    QString m_deadline;
    QString m_investmentStart;
    QString m_investmentEnd;
    QString m_photo;
    QVariantList m_tasks;
};

#endif // PROJECT_H
