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

