#include "transactionsmodel.h"
#include "transaction.h"

#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

TransactionsModel::TransactionsModel(QObject *parent) :
    QAbstractListModel(parent)
{
    m_customNames[TransactionId] = "transactionId";
    m_customNames[Title] = "title";
    m_customNames[Type] = "type";
    m_customNames[Amount] = "amount";
    m_customNames[CreationDate] = "creationDate";
}

int TransactionsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_items.count();
}

QHash<int, QByteArray> TransactionsModel::roleNames() const
{
    return m_customNames;
}

QVariant TransactionsModel::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole && index.row() > m_items.count())
         return QVariant();

    const int row = index.row();

    Transaction *item = m_items.at(row);

    switch(role) {
    case TransactionId:
        return item->id();
    case Title:
        return item->title();
    case Type:
        return item->type();
    case Amount:
        return item->amount();
    case CreationDate:
        return item->creationDate();
    default:
        Q_UNREACHABLE();
        break;
    }

    return QVariant();
}

bool TransactionsModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(role < Qt::UserRole && index.row() > m_items.count())
         return false;

    const int row = index.row();

    Transaction *item = m_items.at(row);

    switch(role) {
    case TransactionId:
        item->setId(value.toInt());
        break;
    case Title:
        item->setTitle(value.toString());
        break;
    case Type:
        item->setType(value.toString());
        break;
    case Amount:
        item->setAmount(value.toDouble());
        break;
    case CreationDate:
        item->setCreationDate(value.toString());
        break;
    default:
        return false;
    }

    dataChanged(index, index);
    return true;
}

void TransactionsModel::parseJsonObject(const QJsonObject &response)
{
    clear();
    beginResetModel();
    QJsonArray walletArray = response.value(QLatin1String("results")).toArray();

    const int arraySize = walletArray.count();

    for(int i = 0; i < arraySize; ++i) {
        QJsonObject projectObject = walletArray.at(i).toObject();

        Transaction *transaction = new Transaction();
        transaction->setId(projectObject.value(QLatin1String("id")).toInt());
        transaction->setTitle(projectObject.value(QLatin1String("project_name")).toString());
        transaction->setAmount(projectObject.value(QLatin1String("amount")).toString().toDouble());
        QDateTime date = QDateTime::fromString(projectObject.value(QLatin1String("created")).toString(), Qt::ISODate);
        transaction->setCreationDate(date.toString(QLatin1String("dd.MM.yyyy")));

        m_items.append(transaction);
    }
    emit transactionsReceived();

    endResetModel();
}

void TransactionsModel::clear()
{
    beginResetModel();
    qDeleteAll(m_items);
    m_items.clear();
    endResetModel();
}
