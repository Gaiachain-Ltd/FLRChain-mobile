#ifndef PROJECT_H
#define PROJECT_H
#include <QObject>
#include <QVariantList>
#include <QVariant>

class Project
{
    Q_GADGET
    Q_PROPERTY(int id READ id WRITE setId)
    Q_PROPERTY(QString name READ name WRITE setName)
    Q_PROPERTY(QString description READ description WRITE setDescription)
    Q_PROPERTY(bool joined READ joined WRITE setJoined)
    Q_PROPERTY(QString status READ status WRITE setStatus)
    Q_PROPERTY(QString deadline READ deadline WRITE setDeadline)
    Q_PROPERTY(QString investmentStart READ investmentStart WRITE setInvestmentStart)
    Q_PROPERTY(QString investmentEnd READ investmentEnd WRITE setInvestmentEnd)
    Q_PROPERTY(QString photo READ photo WRITE setPhoto)
    Q_PROPERTY(QVariantList tasks READ tasks WRITE setTasks)

public:
    Project();

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
