#ifndef REGISTERREQUEST_H
#define REGISTERREQUEST_H

#include "apirequest.h"

#include <QObject>

class RegisterRequest : public ApiRequest
{
    Q_OBJECT

public:
    RegisterRequest(const QString& email, const QString& password);
    void errorHandler(const QString& error);

signals:
    void registrationSuccessful(const QString &email, const QString &password) const;
    void registerError(const QString& error);

protected:
    virtual void parse() override final;
    virtual bool isTokenRequired() const override final;
private:
    QString m_email;
    QString m_password;
};

#endif // REGISTERREQUEST_H
