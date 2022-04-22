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

#include "loginrequest.h"

#include <QJsonObject>
#include <QLoggingCategory>

Q_LOGGING_CATEGORY(requestLogin, "request.login")

LoginRequest::LoginRequest(const QString &email, const QString &password)
    : ApiRequest("login/")
{
    if (!email.isEmpty() && !password.isEmpty()) {
        QJsonObject object;
        object.insert(QLatin1String("username"), QJsonValue(email.toLower()));
        object.insert(QLatin1String("password"), QJsonValue(password));

        m_requestDocument.setObject(object);
        setPriority(Priority::High);
        setType(Type::Post);
    } else {
        qCDebug(requestLogin) << "Error: missing login info"
                              << email << password.length();
    }
}

void LoginRequest::parse()
{
    const QJsonObject object(m_replyDocument.object());
    const QString token(object.value(QLatin1String("token")).toString());

    if (token.isEmpty()) {
        qCDebug(requestLogin) << "Error in parsing server reply"
                              << m_replyDocument.toJson();
        emit loginError("Login error");
        return;
    }

    qCDebug(requestLogin) << "Login successful" << token.length();
    emit loginSuccessful(token);
}

bool LoginRequest::isTokenRequired() const
{
    return false;
}

void LoginRequest::handleError(const QString &errorMessage, const QNetworkReply::NetworkError errorCode)
{
    ApiRequest::handleError(errorMessage, errorCode);

    QString message;

    if (QLatin1String(m_replyData).contains(QLatin1String("Unable to log in with provided credentials."))) {
        message = tr("Unable to log in with provided credentials");
    } else {
        message = tr("Login error");
    }

    emit loginError(message);
}
