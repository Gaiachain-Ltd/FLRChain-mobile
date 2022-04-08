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
    Q_PROPERTY(bool internetConnection WRITE setInternetConnection READ internetConnection NOTIFY internetConnectionChanged)
    Q_PROPERTY(QString apiUrl READ apiUrl CONSTANT)

public:
    explicit Session(QObject *parent = nullptr);
    ~Session();
    void setClient(RestAPIClient *client);
    Q_INVOKABLE bool hasToken() const;
    Q_INVOKABLE void login(const QString& email, const QString& password);
    Q_INVOKABLE void registerUser(const QString& email, const QString& password, const QString &firstName,
                                  const QString &lastName, const QString &phone, const QString &village);
    User* user() const;
    bool internetConnection() const;
    QString apiUrl() const;
    QByteArray getToken() const;
    void setDataManager(DataManager *dataManager);
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
    Q_INVOKABLE void getFacililatorList() const;
    Q_INVOKABLE void cashOut(const QString &amount, const QString &phone) const;
    Q_INVOKABLE void facililatorCashOut(const QString &amount, int facililatorId) const;
    Q_INVOKABLE void getProjectDetails(const int projectId) const;
    Q_INVOKABLE void downloadPhoto(const QString &fileName, const int workId) const;
    Q_INVOKABLE void sendWorkRequest(const int projectId, const int taskId, const QVariantMap &requiredData) const;
    Q_INVOKABLE void saveUserInfo(const QString &firstName,
                                  const QString &lastName,
                                  const QString &phone,
                                  const QString &village) const;
    Q_INVOKABLE void changePassword(const QString &oldPassword,
                                    const QString &newPassword) const;
    Q_INVOKABLE void resetPassword(const QString &email) const;
    Q_INVOKABLE void getMyTasks(const QVariantList &taskIds) const;

public slots:
    void setInternetConnection(const bool internetConnection);

signals:
    void loginSuccessful(const QString& token) const;
    void loginError(const QString& error) const;
    void registrationSuccessful() const;
    void registrationError(const QString& errors) const;
    void userChanged(User* user) const;
    void userInfoError(const QString& error) const;
    void internetConnectionChanged(bool internetConnection);

private:
    void onLoginSuccessful(const QString& token);
    void onUserInfo(const QString &firstName,
                    const QString &lastName,
                    const QString &email,
                    const QString &phone,
                    const QString &village,
                    bool optedIn);
    void setToken(const QByteArray &token);

    UserPtr mCurrentUser;
    QPointer<RestAPIClient> mClient;
    QPointer<DataManager> m_dataManager;
    bool m_internetConnection;
};

#endif // SESSION_H
