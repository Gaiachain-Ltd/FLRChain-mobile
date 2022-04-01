#ifndef FACILILATORLISTREQUEST_H
#define FACILILATORLISTREQUEST_H

#include "apirequest.h"

class FacililatorListRequest : public ApiRequest
{
    Q_OBJECT

public:
    FacililatorListRequest(const QByteArray &token);

signals:
    void facililatorListReply(const QJsonArray &response);

private:
    void parse() final;

};

#endif // FACILILATORLISTREQUEST_H
