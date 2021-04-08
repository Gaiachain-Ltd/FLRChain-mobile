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
    emit fileDownloadResult(m_workId, QString());
}

void GetImageRequest::parse()
{
    emit fileDownloadResult(m_workId, m_cachePath + "/" + QFileInfo(m_url.path()).fileName());
}

void GetImageRequest::readReplyData(const QString &requestName, const QString &status)
{
    QFile file(m_cachePath + "/" + QFileInfo(m_url.path()).fileName());
    if (file.open(QFile::WriteOnly) == false) {
        qDebug() << "Could not open file for writing" << file.fileName()
                 << requestName << status;
        emit fileDownloadResult(m_workId, QString());
        return;
    }

    qDebug() << "Writing file" << file.fileName();
    file.write(m_replyData);
}

bool GetImageRequest::isTokenRequired() const
{
    return true;
}
