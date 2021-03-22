#ifndef GETIMAGEREQUEST_H
#define GETIMAGEREQUEST_H

#include "mimagerequest.h"
#include <QObject>

class GetImageRequest : public ImageRequest
{
    Q_OBJECT

public:
    GetImageRequest(const QByteArray &token, const QUrl& url, const QString &cachePath, const int workId);
    void errorHandler(const QString& error);

signals:
    void fileDownloadError(const int workId) const;
    void fileDownloadSuccessful(const QString &path, const int workId) const;

protected:
    void parse() override;
    void readReplyData(const QString &requestName, const QString &status) override;
    bool isTokenRequired() const override;

private:
    QString m_cachePath;
    int m_workId;
};

#endif // GETIMAGEREQUEST_H
