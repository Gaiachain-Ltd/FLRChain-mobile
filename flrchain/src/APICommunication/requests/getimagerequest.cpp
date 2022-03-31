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
