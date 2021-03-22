#ifndef WORK_H
#define WORK_H
#include <QObject>

class Work : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId)
    Q_PROPERTY(int projectId READ projectId WRITE setProjectId)
    Q_PROPERTY(QString status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(QString date READ date WRITE setDate NOTIFY dateChanged)
    Q_PROPERTY(QString photoPath READ photoPath WRITE setPhotoPath NOTIFY photoPathChanged)
    Q_PROPERTY(QString localPath READ localPath WRITE setLocalPath NOTIFY localPathChanged)
    Q_PROPERTY(double amount READ amount WRITE setAmount NOTIFY amountChanged)

public:
    Work(QObject *parent = nullptr);

    int id() const;
    int projectId() const;
    QString status() const;
    QString date() const;
    QString photoPath() const;
    QString localPath() const;
    double amount() const;

public slots:
    void setId(const int id);
    void setProjectId(const int id);
    void setStatus(const QString &status);
    void setDate(const QString &date);
    void setPhotoPath(const QString &photoPath);
    void setLocalPath(const QString &localPath);
    void setAmount(const double amount);
signals:
    void photoPathChanged(QString photoPath);
    void localPathChanged(QString localPath);
    void statusChanged(QString status);
    void dateChanged(QString date);
    void amountChanged(double amount);

private:
    int m_id;
    int m_projectId;
    QString m_status;
    QString m_date;
    QString m_photoPath;
    QString m_localPath;
    double m_amount;
};

#endif // WORK_H
