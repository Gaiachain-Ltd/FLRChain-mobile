#ifndef REGISTERREQUEST_H
#define REGISTERREQUEST_H

#include "apirequest.h"

#include <QObject>

class RegisterRequest : public ApiRequest
{
    Q_OBJECT

public:
    RegisterRequest(const QString& email, const QString& password, const QString &firstName,
                    const QString &lastName, const QString &phone, const QString &village);
    void errorHandler(const QString& error);

signals:
    void registrationSuccessful() const;
    void registerError(const QString& error);

protected:
    virtual void parse() override final;
    virtual bool isTokenRequired() const override final;
};

#endif // REGISTERREQUEST_H
