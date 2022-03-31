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

#ifndef USERINFOREQUEST_H
#define USERINFOREQUEST_H

#include "apirequest.h"

class UserInfoRequest : public ApiRequest
{
    Q_OBJECT

public:
    UserInfoRequest(const QByteArray &token);

signals:
    void userInfoReply(const QString &firstName,
                       const QString &lastName,
                       const QString &email,
                       const QString &phone,
                       bool optedIn) const;
protected:
    void parse() final;
};

#endif // USERINFOREQUEST_H
