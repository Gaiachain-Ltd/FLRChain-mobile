#ifndef WORK_H
#define WORK_H
#include <QObject>


class Work
{
    Q_GADGET
    Q_PROPERTY(int id READ id WRITE setId)
    Q_PROPERTY(int projectId READ projectId WRITE setProjectId)
    Q_PROPERTY(QString status READ status WRITE setStatus)
    Q_PROPERTY(QString date READ date WRITE setDate)
    Q_PROPERTY(QString photoPath READ photoPath WRITE setPhotoPath)
    Q_PROPERTY(double amount READ amount WRITE setAmount)

public:
    Work();

    int id() const;
    int projectId() const;
    QString status() const;
    QString date() const;
    QString photoPath() const;
    double amount() const;

public slots:
    void setId(const int id);
    void setProjectId(const int id);
    void setStatus(const QString &status);
    void setDate(const QString &date);
    void setPhotoPath(const QString &photoPath);
    void setAmount(const double amount);

private:
    int m_id;
    int m_projectId;
    QString m_status;
    QString m_date;
    QString m_photoPath;
    double m_amount;
};

#endif // WORK_H
Q_DECLARE_METATYPE(Work)
