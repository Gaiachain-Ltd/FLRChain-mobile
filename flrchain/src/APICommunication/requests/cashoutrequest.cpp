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

#include "cashoutrequest.h"

#include <QJsonObject>

CashOutRequest::CashOutRequest(const QString& amount, const QString &phone, const QByteArray &token)
    : ApiRequest("payments/mtn/payout/")
{
    if (!phone.isEmpty() && amount != 0) {
        QJsonObject object;
        object.insert(QLatin1String("amount"), QJsonValue(amount));
        object.insert(QLatin1String("phone"), QJsonValue(phone));

        m_requestDocument.setObject(object);
        setPriority(Priority::High);
        setType(Type::Post);
        setToken(token);
    } else {
        qDebug() << "Error: missing info";
    }
}

void CashOutRequest::parse()
{
    emit transferReply(m_replyDocument.object().value("success").toBool());
}

void CashOutRequest::handleError(const QString &errorMessage, const QNetworkReply::NetworkError errorCode)
{
    ApiRequest::handleError(errorMessage, errorCode);

    emit transferReply(false);
}
