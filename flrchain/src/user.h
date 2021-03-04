#ifndef USER_H
#define USER_H

#include <QObject>
#include <QByteArray>
#include <QString>

class User : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged)
    Q_PROPERTY(QString firstName READ firstName WRITE setFirstName NOTIFY firstNameChanged)
    Q_PROPERTY(QString lastName READ lastName WRITE setLastName NOTIFY lastNameChanged)
public:
    User(QObject *parent = nullptr);
    QString email() const;
    QString firstName() const;
    QString lastName() const;
    QByteArray password() const;
    void setEmail(const QString& email);
    void setFirstName(const QString& name);
    void setLastName(const QString& name);
    void setPassword(const QByteArray& password);
    void clear();

signals:
    void emailChanged() const;
    void firstNameChanged() const;
    void lastNameChanged() const;
    void phoneChanged() const;
    void passwordChanged() const;

private:
    QString m_email;
    QByteArray m_password;
    QString m_firstName;
    QString m_lastName;
};

#endif // USER_H
