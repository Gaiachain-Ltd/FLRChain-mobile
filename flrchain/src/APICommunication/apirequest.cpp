#include "apirequest.h"

ApiRequest::ApiRequest(const QString &apiEndpoint)
    : MRestRequest(QLatin1String("%1/api/v1/%2/?format=json").arg(APIUrl, apiEndpoint))
{
    setPriority(Priority::Normal);

    connect(this, &MRestRequest::replyError,
            this, &ApiRequest::handleError);
}

void ApiRequest::customizeRequest(QNetworkRequest &request)
{
    Q_ASSERT_X(!isTokenRequired() || !m_token.isEmpty(),
               objectName().toLatin1(),
               "This request requires token and it's not provided!");

    if (!m_token.isEmpty()) {
        request.setRawHeader(QByteArray("Authorization"),
                             QStringLiteral("%1 %2").arg("Token", m_token).toLatin1());
    }
}

void ApiRequest::handleError(const QString &errorMessage,
                             const QNetworkReply::NetworkError errorCode)
{
    qCritical() << "HTTP response" << errorCode << errorMessage;
}
