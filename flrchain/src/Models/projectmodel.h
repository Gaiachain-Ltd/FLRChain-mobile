#ifndef PROJECTMODEL_H
#define PROJECTMODEL_H

#include <QAbstractListModel>

#include "typedefs.h"

class ProjectModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum ModelRole
    {
        ProjectIdRole = Qt::UserRole,
        ProjectNameRole,
        ProjectDescriptionRole,
        ProjectPhotoRole,
        ProjectStatusRole,
        ProjectStartDateRole,
        ProjectEndDateRole,
        ProjectAssignmentStatusRole,
        ProjectActionsRole
    };

    explicit ProjectModel(QObject *parent = nullptr);

    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    void clear();

public slots:
    void reloadFromJson(const QJsonObject &response);

signals:
    void projectsReceived();

private:
    ProjectList m_projects;
};

#endif // PROJECTMODEL_H
