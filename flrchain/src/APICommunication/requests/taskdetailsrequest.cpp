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

#include "taskdetailsrequest.h"

#include <QJsonObject>

TaskDetailsRequest::TaskDetailsRequest(const int taskId, const QByteArray &token)
    : ApiRequest(QLatin1String("projects/task/%1/").arg(QString::number(taskId)))
{
    setType(Type::Get);
    setToken(token);
}

void TaskDetailsRequest::parse()
{
    emit taskDetailsReply(m_replyDocument.object());
}

void TaskDetailsRequest::handleError(const QString &errorMessage,
                                     const QNetworkReply::NetworkError errorCode)
{
    ApiRequest::handleError(errorMessage, errorCode);

    emit taskDetailsReplyError(errorMessage);
}
