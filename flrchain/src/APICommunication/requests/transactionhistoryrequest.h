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

#ifndef TRANSACTIONHISTORYREQUEST_H
#define TRANSACTIONHISTORYREQUEST_H

#include "apirequest.h"

#include <QString>
#include <QObject>

class TransactionHistoryRequest : public ApiRequest
{
    Q_OBJECT

public:
    TransactionHistoryRequest(const QByteArray &token);

signals:
    void walletDataReply(const QJsonObject &response) const;

private:
    void parse() final;
};

#endif // TRANSACTIONHISTORYREQUEST_H
