#ifndef FACILITATORLISTREQUEST_H
#define FACILITATORLISTREQUEST_H

#include "apirequest.h"

class FacilitatorListRequest : public ApiRequest
{
    Q_OBJECT

public:
    FacilitatorListRequest(const QByteArray &token);

signals:
    void facilitatorListReply(const QJsonArray &response);

private:
    void parse() final;

};

#endif // FACILITATORLISTREQUEST_H
