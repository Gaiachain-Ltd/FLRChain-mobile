#ifndef PROJECTSMODEL_H
#define PROJECTSMODEL_H


#include <QObject>
#include <QAbstractListModel>

class Project;

class ProjectsModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ModelRole
    {
        ProjectId = Qt::UserRole + 1,
        Name,
        Description,
        Status,
        Deadline,
        InvestmentStart,
        InvestmentEnd,
        Photo,
        AssignmentStatus
    };

    explicit ProjectsModel(QObject *parent = nullptr);

    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const Q_DECL_OVERRIDE;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) Q_DECL_OVERRIDE;
    void clear();
public slots:
    void parseJsonObject(const QJsonObject &response);
signals:
    void projectsReceived();

private:
    QHash<int, QByteArray> m_customNames;
    QVector<Project*> m_items;
};

#endif // PROJECTSMODEL_H
