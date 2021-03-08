#include "restapiclient.h"

#include <QSharedPointer>
#include <QLoggingCategory>

Q_LOGGING_CATEGORY(request, "request")

RestAPIClient::RestAPIClient(QObject *parent)
    : MRestRequestManager(parent)
{
}
