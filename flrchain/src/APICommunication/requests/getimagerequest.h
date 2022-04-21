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

#ifndef GETIMAGEREQUEST_H
#define GETIMAGEREQUEST_H

#include "mimagerequest.h"
#include <QObject>

class GetImageRequest : public ImageRequest
{
    Q_OBJECT

public:
    GetImageRequest(const QByteArray &token, const QUrl& url, const QString &cachePath, const int workId);
    void errorHandler(const QString& error);

signals:
    void fileDownloadResult(const int workId, const QString &path) const;

protected:
    void parse() override;
    void readReplyData(const QString &requestName, const QString &status) override;
    bool isTokenRequired() const override;

private:
    QString m_cachePath;
    int m_workId;
};

#endif // GETIMAGEREQUEST_H
