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

#include "joinprojectrequest.h"
#include <QJsonObject>
#include <QJsonValue>

JoinProjectRequest::JoinProjectRequest(const int projectId, const QByteArray &token)
    : ApiRequest(QString("projects/%1/assignments").arg(projectId))
    , m_projectId(projectId)
{
    setType(Type::Post);
    setToken(token);
}

void JoinProjectRequest::parse()
{
    emit joinProjectReply(m_projectId);
}

void JoinProjectRequest::handleError(const QString &errorMessage,
                                     const QNetworkReply::NetworkError errorCode)
{
    ApiRequest::handleError(errorMessage, errorCode);

    emit joinProjectError();
}
