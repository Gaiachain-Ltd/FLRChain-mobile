#include "filemanager.h"
#include <QStandardPaths>
#include <QDir>
#include <QDebug>
#include <QImageReader>
#include <QImageWriter>
#include "platformbridge.h"
#include <QStringList>

FileManager::FileManager(QObject *parent) : QObject(parent)
{
    QString docLocationRoot = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QString documentsPath = docLocationRoot.append("/photos");

    if (!QDir(documentsPath).exists()) {
        QDir().mkdir(documentsPath);
    }
    setPhotosPath(documentsPath);

    connect(PlatformBridge::instance(), &PlatformBridge::capturedMedia,
            this, &FileManager::handleFileData);
    connect(PlatformBridge::instance(), &PlatformBridge::fileSelected,
            this, &FileManager::copySelectedFile);
}

void FileManager::handleFileData(const QString &filePath)
{
    QImageReader reader(filePath);
    if(reader.canRead()){
        QImage image(filePath);
        if(!image.isNull()){
            QImageWriter writer(filePath);

            writer.setTransformation(reader.transformation());
            writer.setQuality(60);
            writer.setCompression(1);

            if(writer.write(image)){
                setCurrentPhotoPath(reader.fileName());
                emit displayPhoto(reader.fileName());
                return;
            }
        }
    }
    emit photoError();
}

void FileManager::copySelectedFile(const QString &filePath)
{
    if(!filePath.isEmpty()){
        handleFileData(filePath);
    }
    else {
        emit photoError();
    }
}

void FileManager::removeCurrentFile(){
    QFile::remove(currentPhotoPath());
}

QString FileManager::photosPath() const
{
    return mPhotosPath;
}

void FileManager::setPhotosPath(const QString &photosPath)
{
    mPhotosPath = photosPath;
}

QString FileManager::currentPhotoPath() const
{
    return mCurrentPhotoPath;
}

void FileManager::setCurrentPhotoPath(const QString &currentPhotoPath)
{
    mCurrentPhotoPath = currentPhotoPath;
}
