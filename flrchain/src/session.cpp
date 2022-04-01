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

#include "session.h"
#include "user.h"
#include "restapiclient.h"
#include "settings.h"
#include "datamanager.h"
#include "platformbridge.h"
#include "pagemanager.h"
#include <QSharedPointer>
#include <QLoggingCategory>
#include <QDebug>

#include "requests/registerrequest.h"
#include "requests/loginrequest.h"
#include "requests/projectsdatarequest.h"
#include "requests/workdatarequest.h"
#include "requests/userinforequest.h"
#include "requests/joinprojectrequest.h"
#include "requests/transactionhistoryrequest.h"
#include "requests/walletqrcoderequest.h"
#include "requests/walletbalancerequest.h"
#include "requests/cashoutrequest.h"
#include "requests/projectdetailsrequest.h"
#include "requests/getimagerequest.h"
#include "requests/sendworkrequest.h"

Q_LOGGING_CATEGORY(session, "core.session")

Session::Session(QObject *parent) :
    QObject(parent),
    mCurrentUser(UserPtr::create())
{
    connect(PlatformBridge::instance(), &PlatformBridge::networkAvailableChanged,
            this, &Session::setInternetConnection);
    PlatformBridge::instance()->checkConnection();
}

Session::~Session()
{

}

void Session::setClient(RestAPIClient *client)
{
    mClient = client;
}

bool Session::hasToken() const
{
    return !getToken().isEmpty();
}

User* Session::user() const
{
    return mCurrentUser.data();
}

void Session::onLoginSuccessful(const QString &token)
{
    setToken(token.toUtf8());
    emit loginSuccessful(token);
}

void Session::onUserInfo(const QString &firstName, const QString &lastName,
                         const QString &email, const QString &phone, bool optedIn)
{
    if (!firstName.isEmpty()) {
        user()->setFirstName(firstName);
    }
    if (!lastName.isEmpty()){
        user()->setLastName(lastName);
    }
    if (!email.isEmpty()) {
        user()->setEmail(email);
    }
    if (!phone.isEmpty()) {
        user()->setPhone(phone);
    }
    user()->setOptedIn(optedIn);
}

void Session::login(const QString &email, const QString &password)
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send login request!";
        return;
    }

    auto request = QSharedPointer<LoginRequest>::create(email, password);

    connect(request.data(), &LoginRequest::loginSuccessful,
            this, &Session::onLoginSuccessful);
    connect(request.data(), &LoginRequest::loginError,
            this, &Session::loginError);

    mClient->send(request);
}

void Session::registerUser(const QString& email, const QString& password, const QString &firstName,
                           const QString &lastName, const QString &phone, const QString &village)
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    auto request = QSharedPointer<RegisterRequest>::create(email, password, firstName, lastName, phone, village);
    connect(request.data(), &RegisterRequest::registrationSuccessful,
            this, &Session::registrationSuccessful);
    connect(request.data(), &RegisterRequest::registerError,
            this, &Session::registrationError);

    mClient->send(request);
}

void Session::getProjectsData() const
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<ProjectsDataRequest>::create(getToken());
    connect(request.data(), &ProjectsDataRequest::projectsDataReply,
            m_dataManager, &DataManager::projectsDataReply);

    mClient->send(request);
}

void Session::getWorkData(const int projectId) const
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    m_dataManager->cleanPhotosDir();

    auto request = QSharedPointer<WorkDataRequest>::create(getToken(), projectId);
    connect(request.data(), &WorkDataRequest::workDataReply,
            m_dataManager, &DataManager::workReply);

    mClient->send(request);
}

void Session::getUserInfo() const
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<UserInfoRequest>::create(getToken());
    connect(request.data(), &UserInfoRequest::userInfoReply,
            this, &Session::onUserInfo);

    mClient->send(request);
}

void Session::joinProject(const int projectId) const
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<JoinProjectRequest>::create(projectId, getToken());
    connect(request.data(), &JoinProjectRequest::joinProjectReply,
            m_dataManager, &DataManager::joinRequestSent);
    connect(request.data(), &JoinProjectRequest::joinProjectError,
            m_dataManager, &DataManager::joinProjectError);

    mClient->send(request);
}

void Session::getTransactionsData() const
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<TransactionHistoryRequest>::create(getToken());
    connect(request.data(), &TransactionHistoryRequest::walletDataReply,
            m_dataManager, &DataManager::transactionsDataReply);

    mClient->send(request);
}

void Session::getWalletBalance() const
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<WalletBalanceRequest>::create(getToken());
    connect(request.data(), &WalletBalanceRequest::walletBalanceReply,
            m_dataManager, &DataManager::walletBalanceReceived);

    mClient->send(request);
}

void Session::getWalletQRCode() const
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<WalletQRCodeRequest>::create(getToken());
    connect(request.data(), &WalletQRCodeRequest::walletQRCodeReply,
            m_dataManager, &DataManager::walletQRCodeReceived);

    mClient->send(request);
}

void Session::cashOut(const QString& amount, const QString& phone) const
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<CashOutRequest>::create(amount, phone, getToken());
    connect(request.data(), &CashOutRequest::transferReply,
            m_dataManager, &DataManager::cashOutReplyReceived);

    mClient->send(request);
}

void Session::getProjectDetails(const int projectId) const
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<ProjectDetailsRequest>::create(getToken(), projectId);
    connect(request.data(), &ProjectDetailsRequest::projectDetailsReply,
            m_dataManager, &DataManager::projectDetailsReply);

    mClient->send(request);
}

void Session::downloadPhoto(const QString &fileName, const int workId) const
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<GetImageRequest>::create(getToken(), QUrl(APIUrl + fileName), m_dataManager->getPhotosPath(), workId);
    connect(request.data(), &GetImageRequest::fileDownloadResult,
            m_dataManager, &DataManager::photoDownloadResult);

    mClient->send(request);
}

void Session::sendWorkRequest(const QString &filePath, const int projectId, const int taskId) const
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<SendWorkRequest>::create(filePath, projectId, taskId, getToken());
    connect(request.data(), &SendWorkRequest::workAdded,
            m_dataManager, &DataManager::workAdded);
    connect(request.data(), &SendWorkRequest::sendWorkError,
            m_dataManager, &DataManager::addWorkError);

    mClient->send(request);
}

void Session::setRememberMe(const bool val)
{
    Settings::instance()->setValue(Settings::RememberMe, val);
}

bool Session::getRememberMe() const
{
    return Settings::instance()->getValue(Settings::RememberMe).toBool();
}

void Session::setToken(const QByteArray &val)
{
    Settings::instance()->setValue(Settings::Token, val);
}

QByteArray Session::getToken() const
{
    return Settings::instance()->getValue(Settings::Token).toByteArray();
}

void Session::setDataManager(DataManager *dataManager)
{
    m_dataManager = dataManager;

    connect(m_dataManager, &DataManager::downloadRequest,
            this, &Session::downloadPhoto);
}

void Session::logout()
{
    mCurrentUser->clear();
    m_dataManager->cleanData();
    setRememberMe(0);
    setToken(QByteArray());
    PageManager::instance()->closeAll();
    PageManager::instance()->enterLoginScreen();
}

void Session::setInternetConnection(const bool internetConnection)
{
    if (m_internetConnection != internetConnection) {
        m_internetConnection = internetConnection;
        emit internetConnectionChanged(internetConnection);
    }
}

bool Session::internetConnection() const
{
    return m_internetConnection;
}

QString Session::apiUrl() const
{
    return APIUrl;
}
