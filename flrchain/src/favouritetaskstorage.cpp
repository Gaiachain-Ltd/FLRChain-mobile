#include "favouritetaskstorage.h"

#include <QGlobalStatic>
#include <QCoreApplication>

Q_GLOBAL_STATIC(FavouriteTaskStorage, favouriteTaskManagerInstance)

namespace
{
    constexpr QStringView STORAGE_KEY = u"favourites";
}

FavouriteTaskStorage::FavouriteTaskStorage(QObject *parent)
    : QObject(parent)
    , m_storage(QSettings::IniFormat,
                QSettings::UserScope,
                qApp->organizationName(),
                qApp->applicationName())
{
    m_cache = m_storage.value(STORAGE_KEY.toString()).toHash();
}

FavouriteTaskStorage &FavouriteTaskStorage::instance()
{
    return *favouriteTaskManagerInstance;
}

bool FavouriteTaskStorage::isTaskFavourite(const int taskId) const
{
    return m_cache.contains(QString::number(taskId));
}

void FavouriteTaskStorage::setTaskFavouriteStatus(const int taskId,
                                                  const bool isFavourite)
{
    if (isFavourite) {
        m_cache.insert(QString::number(taskId), true);
    } else {
        m_cache.remove(QString::number(taskId));
    }

    m_storage.setValue(STORAGE_KEY.toString(), m_cache);
}
