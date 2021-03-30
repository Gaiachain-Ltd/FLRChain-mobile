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
    Q_PROPERTY(QString type READ type WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(double amount READ amount WRITE setAmount NOTIFY amountChanged)

public:
    Transaction(QObject *parent = nullptr);

    int id() const;
    QString title() const;
    QString type() const;
    double amount() const;

public slots:
    void setId(const int id);
    void setTitle(const QString &title);
    void setType(const QString &type);
    void setAmount(const double amount);

signals:
    void idChanged(int id);
    void titleChanged(QString title);
    void typeChanged(QString type);
    void amountChanged(double amount);

private:
    int m_id;
    QString m_title;
    QString m_type;
    double m_amount;
};

#endif // PROJECT_H
