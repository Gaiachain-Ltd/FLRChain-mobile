#ifndef TASKSMODEL_H
#define TASKSMODEL_H

#include <QObject>
#include <QAbstractListModel>

class Task;

class TasksModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ModelRole
    {
        TaskId = Qt::UserRole + 1,
        ProjectId,
        Action,
        Reward
    };

    explicit TasksModel(QObject *parent = nullptr);

    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const Q_DECL_OVERRIDE;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) Q_DECL_OVERRIDE;
    int findRowById(const int id) const;
    void updatePhoto(const QString &path, const int id);
    void clear();
public slots:
    void parseJsonObject(const QJsonObject &response);
signals:
    void tasksReceived();

private:
    QHash<int, QByteArray> m_customNames;
    QVector<Task*> m_items;
};

#endif // TASKSMODEL_H
