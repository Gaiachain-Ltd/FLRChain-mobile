#include "transaction.h"

Transaction::Transaction(QObject *parent) :
    QObject(parent),
    m_id(),
    m_title(QString()),
    m_type(QString()),
    m_amount(0)
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

QString Transaction::type() const
{
    return m_type;
}

double Transaction::amount() const
{
    return m_amount;
}

QString Transaction::creationDate() const
{
    return m_creationDate;
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

void Transaction::setType(const QString &type)
{
    if (m_type != type) {
        m_type = type;
        emit typeChanged(type);
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
