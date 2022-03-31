/*
 * Copyright (C) 2022  Milo Solutions
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

#ifndef WORKMODEL_H
#define WORKMODEL_H

#include <QObject>
#include <QAbstractListModel>

class Work;

class WorkModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ModelRole
    {
        WorkId = Qt::UserRole + 1,
        ProjectId,
        Status,
        Date,
        PhotoPath,
        LocalPath,
        Amount
    };

    explicit WorkModel(QObject *parent = nullptr);

    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const Q_DECL_OVERRIDE;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) Q_DECL_OVERRIDE;
    int findRowById(const int id) const;
    void clear();

public slots:
    void parseJsonObject(const QJsonObject &response);
    void photoDownloadResult(const int workId, const QString &photoPath = QString());
signals:
    void workReceived(const double balance);
    void downloadPhoto(const QString &path, const int id);
    void workUpdated();
private:
    QHash<int, QByteArray> m_customNames;
    QVector<Work*> m_items;
};

#endif // WORKMODEL_H
