#ifndef USER_H
#define USER_H

#include <QObject>
#include <QByteArray>
#include <QString>

class User : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString phone READ phone WRITE setPhone NOTIFY phoneChanged)
    Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged)
    Q_PROPERTY(QString firstName READ firstName WRITE setFirstName NOTIFY firstNameChanged)
    Q_PROPERTY(QString lastName READ lastName WRITE setLastName NOTIFY lastNameChanged)
    Q_PROPERTY(bool optedIn READ optedIn WRITE setOptedIn NOTIFY optedInChanged)
public:
    User(QObject *parent = nullptr);

    QString email() const;
    QString firstName() const;
    QString lastName() const;
    bool optedIn() const;
    QByteArray password() const;
    const QString &phone() const;

    void setEmail(const QString& email);
    void setFirstName(const QString& name);
    void setLastName(const QString& name);
    void setPassword(const QByteArray& password);
    void setOptedIn(bool optedIn);
    void setPhone(const QString &newPhone);

    void clear();

signals:
    void emailChanged() const;
    void firstNameChanged() const;
    void lastNameChanged() const;
    void phoneChanged() const;
    void passwordChanged() const;
    void optedInChanged() const;

private:
    QString m_email;
    QByteArray m_password;
    QString m_firstName;
    QString m_lastName;
    QString m_phone;
    bool m_optedIn;
};

#endif // USER_H
