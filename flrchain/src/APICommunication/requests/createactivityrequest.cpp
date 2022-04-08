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

#include "createactivityrequest.h"

#include <QJsonObject>

CreateActivityRequest::CreateActivityRequest(const int projectId,
                                             const int taskId,
                                             const QVariantMap &data,
                                             const QByteArray &token)
    : ApiRequest(QLatin1String("projects/%1/tasks/%2/activities").arg(QString::number(projectId),
                                                                      QString::number(taskId)))
{
    setType(Type::Post);
    setToken(token);
    setDocument(QJsonDocument(QJsonObject::fromVariantMap(data)));
}

void CreateActivityRequest::parse()
{
    emit activityCreated(m_replyDocument.object());
}

void CreateActivityRequest::handleError(const QString &errorMessage,
                                        const QNetworkReply::NetworkError errorCode)
{
    qCritical() << "HTTP response" << errorCode << errorMessage;

    emit activityCreationFailed(errorMessage);
}
