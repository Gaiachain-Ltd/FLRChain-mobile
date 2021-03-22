#include "getimagerequest.h"
#include <QFile>
#include <QFileInfo>

GetImageRequest::GetImageRequest(const QByteArray &token, const QUrl& url, const QString &cachePath, const int workId)
    : ImageRequest(url, cachePath)
{
    m_cachePath = cachePath;
    m_workId = workId;
    setPriority(Priority::Normal);
    setType(Type::Get);
    setToken(token);
    connect(this, &GetImageRequest::replyError, this, &GetImageRequest::errorHandler);
}

void GetImageRequest::errorHandler(const QString &error)
{
    qDebug() << "Error" << error;
    emit fileDownloadError(m_workId);
}

void GetImageRequest::parse()
{
    emit fileDownloadSuccessful(m_cachePath + "/" + QFileInfo(m_url.path()).fileName(), m_workId);
}

void GetImageRequest::readReplyData(const QString &requestName, const QString &status)
{
    QFile file(m_cachePath + "/" + QFileInfo(m_url.path()).fileName());
    if (file.open(QFile::WriteOnly) == false) {
        qDebug() << "Could not open file for writing" << file.fileName()
                 << requestName << status;
        emit fileDownloadError(m_workId);
        return;
    }

    qDebug() << "Writing file" << file.fileName();
    file.write(m_replyData);
}

bool GetImageRequest::isTokenRequired() const
{
    return true;
}
