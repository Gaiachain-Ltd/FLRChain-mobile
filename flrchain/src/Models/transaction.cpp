#include "transaction.h"

Transaction::Transaction(QObject *parent) :
    QObject(parent),
    m_id(),
    m_title(QString()),
    m_action(0),
    m_amount(0),
    m_status(2)
{

}

int Transaction::id() const
{
    return m_id;
}

QString Transaction::title() const
{
    return m_title;
}

int Transaction::action() const
{
    return m_action;
}

double Transaction::amount() const
{
    return m_amount;
}

QString Transaction::creationDate() const
{
    return m_creationDate;
}

int Transaction::status() const
{
    return m_status;
}

void Transaction::setId(const int id)
{
    if (m_id != id) {
        m_id = id;
        emit idChanged(id);
    }
}

void Transaction::setTitle(const QString &title)
{
    if (m_title != title) {
        m_title = title;
        emit titleChanged(title);
    }
}

void Transaction::setAction(const int action)
{
    if (m_action != action) {
        m_action = action;
        emit actionChanged(action);
    }
}

void Transaction::setAmount(const double amount)
{
    if (m_amount != amount) {
        m_amount = amount;
        emit amountChanged(amount);
    }
}

void Transaction::setCreationDate(const QString &creationDate)
{
    if (m_creationDate != creationDate) {
        m_creationDate = creationDate;
        emit creationDateChanged(creationDate);
    }
}

void Transaction::setStatus(int status)
{
    if (m_status == status)
        return;

    m_status = status;
    emit statusChanged(m_status);
}
