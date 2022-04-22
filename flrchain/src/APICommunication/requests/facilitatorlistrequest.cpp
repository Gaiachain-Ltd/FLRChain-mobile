#include "facilitatorlistrequest.h"

#include <QJsonArray>

FacilitatorListRequest::FacilitatorListRequest(const QByteArray &token)
    : ApiRequest("payments/facililator/")
{
    setType(Type::Get);
    setToken(token);
}

void FacilitatorListRequest::parse()
{
    emit facilitatorListReply(m_replyDocument.array());
}
