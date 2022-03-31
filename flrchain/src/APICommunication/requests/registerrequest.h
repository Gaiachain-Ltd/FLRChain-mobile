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

#ifndef REGISTERREQUEST_H
#define REGISTERREQUEST_H

#include "apirequest.h"

class RegisterRequest : public ApiRequest
{
    Q_OBJECT

public:
    RegisterRequest(const QString& email, const QString& password, const QString &firstName,
                    const QString &lastName, const QString &phone, const QString &village);

signals:
    void registrationSuccessful() const;
    void registerError(const QString& error);

private:
    void parse() final;
    bool isTokenRequired() const final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;
};

#endif // REGISTERREQUEST_H
