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

#ifndef CASHOUTREQUEST_H
#define CASHOUTREQUEST_H

#include "apirequest.h"

#include <QObject>

class CashOutRequest : public ApiRequest
{
    Q_OBJECT

public:
    CashOutRequest(const QString& amount, const QString &phone, const QByteArray &token);

signals:
    void transferSuccess(const QString &amount, const QString &phone);
    void transferFailed(const QString &errorMessage);

private:
    void parse() final;
    void handleError(const QString &errorMessage,
                     const QNetworkReply::NetworkError errorCode) final;

    QString m_amount;
    QString m_phone;
};

#endif // CASHOUTREQUEST_H
