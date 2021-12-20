#ifndef TRANSACTIONSMODEL_H
#define TRANSACTIONSMODEL_H

#include <QObject>
#include <QAbstractListModel>

class Transaction;

class TransactionsModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ModelRole
    {
        TransactionId = Qt::UserRole + 1,
        Title,
        Action,
        Amount,
        CreationDate,
        Status,
    };

    explicit TransactionsModel(QObject *parent = nullptr);

    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const Q_DECL_OVERRIDE;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) Q_DECL_OVERRIDE;
    void clear();
public slots:
    void parseJsonObject(const QJsonObject &response);
signals:
    void transactionsReceived();

private:
    QHash<int, QByteArray> m_customNames;
    QVector<Transaction*> m_items;
};

#endif // TRANSACTIONSMODEL_H
