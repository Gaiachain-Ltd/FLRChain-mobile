#ifndef FILEMANAGER_H
#define FILEMANAGER_H

#include <QObject>

class FileManager : public QObject
{
    Q_OBJECT

public:
    explicit FileManager(QObject *parent = nullptr);
    Q_INVOKABLE void handleFileData(const QString &filePath);
    Q_INVOKABLE void onFileSelected(const QString &filePath);

    void removeCurrentFile();
    QString photosPath() const;
    void setPhotosPath(const QString &photosPath);

    QString currentPhotoPath() const;
    void setCurrentPhotoPath(const QString &currentPhotoPath);
    void cleanDir();
signals:
    void displayPhoto(const QString &filePath);
    void photoError();
    void processingPhoto();
private:
    QString mPhotosPath;
    QString mCurrentPhotoPath;
};

#endif // FILEMANAGER_H
