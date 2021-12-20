#ifndef TRANSACTION_H
#define TRANSACTION_H
#include <QObject>
#include <QVariantList>
#include <QVariant>

class Transaction : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(int action READ action WRITE setAction NOTIFY actionChanged)
    Q_PROPERTY(double amount READ amount WRITE setAmount NOTIFY amountChanged)
    Q_PROPERTY(QString creationDate READ creationDate WRITE setCreationDate NOTIFY creationDateChanged)
    Q_PROPERTY(int status READ status WRITE setStatus NOTIFY statusChanged)

public:
    Transaction(QObject *parent = nullptr);

    int id() const;
    QString title() const;
    int action() const;
    double amount() const;
    QString creationDate() const;
    int status() const;

public slots:
    void setId(const int id);
    void setTitle(const QString &title);
    void setAction(const int action);
    void setAmount(const double amount);
    void setCreationDate(const QString &creationDate);
    void setStatus(int status);

signals:
    void idChanged(int id);
    void titleChanged(QString title);
    void actionChanged(int action);
    void amountChanged(double amount);
    void creationDateChanged(QString creationDate);
    void statusChanged(int status);

private:
    int m_id;
    QString m_title;
    int m_action;
    double m_amount;
    QString m_creationDate;
    int m_status;
};

#endif // PROJECT_H
