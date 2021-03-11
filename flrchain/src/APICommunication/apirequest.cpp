#include "apirequest.h"

ApiRequest::ApiRequest(const QString &method)
    : MRestRequest()
{
    setMethod(method);
    setPriority(Priority::Normal);
}

void ApiRequest::setMethod(const QString &apiMethodPath)
{
    mApiMethod = apiMethodPath;
    setAddress(QUrl(APIUrl + mApiMethod + "/?format=json"));
}

void ApiRequest::customizeRequest(QNetworkRequest &request)
{
    Q_ASSERT_X(!isTokenRequired() || !m_token.isEmpty(),
               objectName().toLatin1(),
               "This request require token and it's not provided!");

    if (!m_token.isEmpty()) {
        request.setRawHeader(QByteArray("Authorization"),
                             QStringLiteral("%1 %2").arg("Token", m_token).toLatin1());
    }
}
