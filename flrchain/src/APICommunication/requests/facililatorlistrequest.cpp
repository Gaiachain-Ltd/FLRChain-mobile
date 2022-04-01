#include "facililatorlistrequest.h"

#include <QJsonArray>

FacililatorListRequest::FacililatorListRequest(const QByteArray &token)
    : ApiRequest("payments/facililator")
{
    setType(Type::Get);
    setToken(token);
}

void FacililatorListRequest::parse()
{
    emit facililatorListReply(m_replyDocument.array());
}
