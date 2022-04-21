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

#include "userinforequest.h"

#include <QJsonObject>

UserInfoRequest::UserInfoRequest(const QByteArray &token)
    : ApiRequest("info")
{
    setType(Type::Get);
    setToken(token);
}

void UserInfoRequest::parse()
{
    const QJsonObject object(m_replyDocument.object());

    qDebug() << "Info:" << object;

    const QString firstName(object.value(QLatin1String("first_name")).toString());
    const QString lastName(object.value(QLatin1String("last_name")).toString());
    const QString email(object.value(QLatin1String("email")).toString());
    const QString phone(object.value(QLatin1String("phone")).toString());
    const QString village(object.value(QLatin1String("village")).toString());
    const bool optedIn = object.value(QLatin1String("opted_in")).toBool();

    emit userInfoReply(firstName, lastName, email, phone, village, optedIn);
}
