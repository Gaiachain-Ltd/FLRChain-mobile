#ifndef RESTAPICLIENT_H
#define RESTAPICLIENT_H

#include "mrestrequestmanager.h"

#include <QObject>

class RestAPIClient : public MRestRequestManager
{
    Q_OBJECT

public:
    explicit RestAPIClient(QObject *parent = nullptr);
};

#endif // RESTAPICLIENT_H
