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

#ifndef FAVOURITETASKSTORAGE_H
#define FAVOURITETASKSTORAGE_H

#include <QObject>
#include <QVariantHash>
#include <QSettings>

class FavouriteTaskStorage : public QObject
{
    Q_OBJECT

public:
    explicit FavouriteTaskStorage(QObject *parent = nullptr);
    static FavouriteTaskStorage &instance();

    bool isTaskFavourite(const int taskId) const;
    void setTaskFavouriteStatus(const int taskId, const bool isFavourite);

    Q_INVOKABLE QVariantList favouriteIds() const;

private:
    QVariantList m_cache;
    QSettings m_storage;
};

#endif // FAVOURITETASKSTORAGE_H
