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

#include "apimultipartrequest.h"

ApiMultiPartRequest::ApiMultiPartRequest(const QString &apiEndpoint)
    : MMultiPartRequest(QLatin1String("%1/api/v1/%2").arg(APIUrl, apiEndpoint))
{
    setPriority(Priority::Normal);

    connect(this, &MRestRequest::replyError,
            this, &ApiMultiPartRequest::handleError);
}

void ApiMultiPartRequest::customizeRequest(QNetworkRequest &request)
{
    Q_ASSERT_X(!isTokenRequired() || !m_token.isEmpty(),
               objectName().toLatin1(),
               "This request requires token and it's not provided!");

    request.setHeader(QNetworkRequest::UserAgentHeader, "Qt");

    if (!m_token.isEmpty()) {
        request.setRawHeader(QByteArray("Authorization"),
                             QStringLiteral("%1 %2").arg("Token", m_token).toLatin1());
    }
}

void ApiMultiPartRequest::handleError(const QString &errorMessage,
                                      const QNetworkReply::NetworkError errorCode)
{
    qCritical() << "HTTP response" << errorCode << errorMessage;
}
