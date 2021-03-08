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
    setAddress(QUrl("http://195.201.81.231:8000/api/v1/" + mApiMethod + "/?format=json"));
}

