#include "filemanager.h"
#include <QStandardPaths>
#include <QDir>
#include <QDebug>

FileManager::FileManager(QObject *parent) : QObject(parent)
{
    QString docLocationRoot = QStandardPaths::standardLocations(QStandardPaths::AppDataLocation).value(0);
    QString mDocumentsWorkPath = docLocationRoot.append("/photos");

    if (!QDir(mDocumentsWorkPath).exists()) {
        QDir().mkdir(mDocumentsWorkPath);
    }
}

