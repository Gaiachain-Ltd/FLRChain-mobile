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

#include "projectsdatarequest.h"

#include <QJsonObject>

ProjectsDataRequest::ProjectsDataRequest(const QByteArray &token, const bool loadAllData)
    : ApiRequest(QLatin1String("projects") + (loadAllData ? "/" : "/?nodetails=true"))
{
    setType(Type::Get);
    setToken(token);
}

void ProjectsDataRequest::parse()
{
    emit projectsDataReply(m_replyDocument.object());
}
