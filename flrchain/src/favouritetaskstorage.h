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

private:
    QVariantHash m_cache;
    QSettings m_storage;
};

#endif // FAVOURITETASKSTORAGE_H
