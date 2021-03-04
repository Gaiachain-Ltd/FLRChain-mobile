#ifndef APIREQUEST_H
#define APIREQUEST_H

#include "mrestrequest.h"

#include <QUrl>
#include <QString>
#include <QObject>

class ApiRequest : public MRestRequest
{
    Q_OBJECT

public:
    explicit ApiRequest(const QString &method);
    void setMethod(const QString &apiMethodPath);

protected:
    QString mApiMethod;
};

#endif // APIREQUEST_H
