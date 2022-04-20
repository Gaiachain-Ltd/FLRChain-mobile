/*
 * Copyright (C) 2022  Milo Solutions
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

#ifndef SESSION_H
#define SESSION_H

#include <QByteArray>
#include <QObject>
#include <QPointer>
#include "types.h"
#include "datamanager.h"

class RestAPIClient;

class Session : public QObject
{
    Q_OBJECT
    Q_PROPERTY(User* user READ user NOTIFY userChanged)
    Q_PROPERTY(bool internetConnection READ internetConnection NOTIFY internetConnectionChanged)
    Q_PROPERTY(QString apiUrl READ apiUrl CONSTANT)

public:
    explicit Session(QObject *parent = nullptr);
    ~Session();

    void setClient(RestAPIClient *client);
    void setDataManager(DataManager *dataManager);

    User* user() const;
    bool internetConnection() const;
    QString apiUrl() const;
    Q_INVOKABLE bool hasToken() const;
    QByteArray getToken() const;

    Q_INVOKABLE void login(const QString& email, const QString& password);
    Q_INVOKABLE void registerUser(const QString& email, const QString& password, const QString &firstName,
                                  const QString &lastName, const QString &phone, const QString &village);
    Q_INVOKABLE void setRememberMe(const bool val);
    Q_INVOKABLE bool getRememberMe() const;
    Q_INVOKABLE void logout();

    Q_INVOKABLE void getProjectsData() const;
    Q_INVOKABLE void getWorkData(const int projectId) const;
    Q_INVOKABLE void getUserInfo() const;
    Q_INVOKABLE void joinProject(const int projectId) const;
    Q_INVOKABLE void getTransactionsData() const;
    Q_INVOKABLE void getWalletBalance() const;
    Q_INVOKABLE void getWalletQRCode() const;
    Q_INVOKABLE void getFacilitatorList() const;
    Q_INVOKABLE void cashOut(const QString &amount, const QString &phone) const;
    Q_INVOKABLE void facilitatorCashOut(const QString &amount, int facilitatorId) const;
    Q_INVOKABLE void getProjectDetails(const int projectId) const;
    Q_INVOKABLE void downloadPhoto(const QString &fileName, const int workId) const;
    Q_INVOKABLE void sendWorkRequest(const int projectId, const int taskId, const QVariantMap &requiredData);
    Q_INVOKABLE void saveUserInfo(const QString &firstName,
                                  const QString &lastName,
                                  const QString &phone,
                                  const QString &village) const;
    Q_INVOKABLE void changePassword(const QString &oldPassword,
                                    const QString &newPassword) const;
    Q_INVOKABLE void resetPassword(const QString &email) const;
    Q_INVOKABLE void getMyTasks(const QVariantList &taskIds) const;

signals:
    void loginError(const QString& error);
    void registrationSuccessful();
    void registrationError(const QString& errors);
    void resetPasswordSuccessful();
    void resetPasswordError(const QString &error);
    void userChanged(User* user);
    void userInfoError(const QString& error);
    void internetConnectionChanged(bool internetConnection);
    void walletBalanceReceived(const qreal balance);
    void walletQRCodeReceived(const QString &qrCode);
    void facilitatorListReceived(const QJsonArray &facilitators);
    void sendWorkJobFinished();

private:
    void setInternetConnection(const bool internetConnection);
    void setToken(const QByteArray &token);

    void onResetPasswordResult(const bool wasSuccessful, const QString &errorMessage);
    void onUserInfo(const QString &firstName,
                    const QString &lastName,
                    const QString &email,
                    const QString &phone,
                    const QString &village,
                    bool optedIn);
    void onCashOutReplyReceived(const bool result);

    UserPtr m_currentUser;
    QPointer<RestAPIClient> m_apiClient;
    QPointer<DataManager> m_dataManager;
    bool m_internetConnection;
};

#endif // SESSION_H
