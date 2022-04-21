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

#include "favouritetaskstorage.h"

#include <QGlobalStatic>
#include <QCoreApplication>
#include <QQmlEngine>

Q_GLOBAL_STATIC(FavouriteTaskStorage, favouriteTaskManagerInstance)

namespace
{
    constexpr QStringView STORAGE_KEY = u"favourites";

    void registerInQml()
    {
        QQmlEngine::setObjectOwnership(favouriteTaskManagerInstance, QQmlEngine::CppOwnership);

        qmlRegisterSingletonInstance<FavouriteTaskStorage>("com.flrchain.objects", 1, 0,
                                                           "FavouriteTaskStorage",
                                                           favouriteTaskManagerInstance);
    }
}

FavouriteTaskStorage::FavouriteTaskStorage(QObject *parent)
    : QObject(parent)
    , m_storage(QSettings::IniFormat,
                QSettings::UserScope,
                qApp->organizationName(),
                qApp->applicationName())
{
    m_cache = m_storage.value(STORAGE_KEY.toString()).toList();
}

FavouriteTaskStorage &FavouriteTaskStorage::instance()
{
    return *favouriteTaskManagerInstance;
}

bool FavouriteTaskStorage::isTaskFavourite(const int taskId) const
{
    return m_cache.contains(taskId);
}

void FavouriteTaskStorage::setTaskFavouriteStatus(const int taskId,
                                                  const bool isFavourite)
{
    if (isFavourite) {
        m_cache.append(taskId);
    } else {
        m_cache.removeAll(taskId);
    }

    m_storage.setValue(STORAGE_KEY.toString(), m_cache);
}

QVariantList FavouriteTaskStorage::favouriteIds() const
{
    return m_cache;
}

Q_COREAPP_STARTUP_FUNCTION(registerInQml)
