#include "user.h"

User::User(QObject *parent) :
    QObject(parent)
{

}

QString User::email() const
{
    return m_email;
}

QString User::firstName() const
{
    return m_firstName;
}

QString User::lastName() const
{
    return m_lastName;
}

QByteArray User::password() const
{
    return m_password;
}

bool User::optedIn() const
{
    return m_optedIn;
}

void User::setEmail(const QString& email)
{
    if (m_email != email) {
        m_email = email;
        emit emailChanged();
    }
}

void User::setFirstName(const QString& name)
{
    if (m_firstName != name) {
        m_firstName = name;
        emit firstNameChanged();
    }
}

void User::setLastName(const QString& name)
{
    if (m_lastName != name) {
        m_lastName = name;
        emit lastNameChanged();
    }
}

void User::setOptedIn(bool optedIn)
{
    if (m_optedIn == optedIn)
        return;

    m_optedIn = optedIn;
    emit optedInChanged();
}

void User::setPassword(const QByteArray& password)
{
    if (m_password != password) {
        m_password = password;
        emit passwordChanged();
    }
}

void User::clear()
{
    setEmail(QString());
    setPassword(QByteArray());
    setFirstName(QString());
    setLastName(QString());
    setOptedIn(false);
}
