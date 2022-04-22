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

#include "facilitatorcashoutrequest.h"

#include <QJsonObject>

FacilitatorCashOutRequest::FacilitatorCashOutRequest(const QString &amount,
                                                     const int facilitatorId,
                                                     const QString &facilitatorName,
                                                     const QByteArray &token)
    : ApiRequest("payments/facililator/")
    , m_amount(amount)
    , m_facilitatorName(facilitatorName)
{
    if (!amount.isEmpty() && facilitatorId > 0) {
        QJsonObject object;
        object.insert(QLatin1String("amount"), QJsonValue(amount));
        object.insert(QLatin1String("id"), QJsonValue(facilitatorId));

        m_requestDocument.setObject(object);
        setPriority(Priority::High);
        setType(Type::Post);
        setToken(token);
    } else {
        qCritical() << "Error: incorrect info";
    }
}

void FacilitatorCashOutRequest::parse()
{
    const QJsonObject replyObject = m_replyDocument.object();

    if (replyObject.value(u"success").toBool()) {
        emit transferSuccess(m_amount, m_facilitatorName, replyObject.value(u"txid").toString());
    } else {
        emit transferFailed(tr("Unknown issue occurred."));
    }
}

void FacilitatorCashOutRequest::handleError(const QString &errorMessage,
                                            const QNetworkReply::NetworkError errorCode)
{
    ApiRequest::handleError(errorMessage, errorCode);

    emit transferFailed(errorMessage);
}
