#include "apirequest.h"

#include <QDebug>

ApiRequest::ApiRequest(const QString &method)
    : MRestRequest()
{
    setMethod(method);
    m_priority = Priority::Normal;
}

void ApiRequest::setMethod(const QString &apiMethodPath)
{
    mApiMethod = apiMethodPath;
    m_url = QUrl("http://195.201.81.231:8000/api/v1/" + mApiMethod + "/?format=json");
}

