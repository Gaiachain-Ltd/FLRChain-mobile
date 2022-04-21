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
#include "AppNavigationController.h"

#include <QSharedPointer>
#include <QLoggingCategory>
#include <QDebug>

#include "requests/registerrequest.h"
#include "requests/loginrequest.h"
#include "requests/projectsdatarequest.h"
#include "requests/workdatarequest.h"
#include "requests/userinforequest.h"
#include "requests/saveuserinforequest.h"
#include "requests/joinprojectrequest.h"
#include "requests/transactionhistoryrequest.h"
#include "requests/walletqrcoderequest.h"
#include "requests/walletbalancerequest.h"
#include "requests/facilitatorlistrequest.h"
#include "requests/cashoutrequest.h"
#include "requests/facilitatorcashoutrequest.h"
#include "requests/projectdetailsrequest.h"
#include "requests/getimagerequest.h"
#include "requests/sendworkrequest.h"
#include "requests/changepasswordrequest.h"
#include "requests/resetpasswordrequest.h"
#include "requests/sendworkjob.h"
#include "requests/mytasksrequest.h"

Q_LOGGING_CATEGORY(session, "core.session")

Session::Session(QObject *parent)
    : QObject(parent)
    , m_currentUser(UserPtr::create())
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
    m_apiClient = client;
}

bool Session::hasToken() const
{
    return !getToken().isEmpty();
}

User *Session::user() const
{
    return m_currentUser.data();
}

void Session::onResetPasswordResult(const bool wasSuccessful, const QString &errorMessage)
{
    if (wasSuccessful) {
        emit resetPasswordSuccessful();
    } else {
        emit resetPasswordError(errorMessage);
    }
}

void Session::onUserInfo(const QString &firstName, const QString &lastName,
                         const QString &email, const QString &phone, const QString &village,
                         bool optedIn)
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
    if (!village.isEmpty()) {
        user()->setVillage(village);
    }

    user()->setOptedIn(optedIn);
}

void Session::login(const QString &email, const QString &password)
{
    if (m_apiClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send login request!";
        return;
    }

    auto request = QSharedPointer<LoginRequest>::create(email, password);

    connect(request.data(), &LoginRequest::loginSuccessful,
            this, [&](const QString &token)
    {
        setToken(token.toUtf8());

        getUserInfo();
        AppNavigationController::instance().replaceAllPages(AppNavigation::PageID::DashboardPage);
    });

    connect(request.data(), &LoginRequest::loginError,
            this, [&](const QString &errorMessage)
    {
        AppNavigationController::instance().openPopup(AppNavigation::PopupID::ErrorPopup, {
                                                          {"errorMessage", errorMessage}
                                                      });
    });

    m_apiClient->send(request);
}

void Session::registerUser(const QString &email, const QString &password, const QString &firstName,
                           const QString &lastName, const QString &phone, const QString &village)
{
    if (m_apiClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    auto request = QSharedPointer<RegisterRequest>::create(email, password, firstName, lastName, phone, village);
    connect(request.data(), &RegisterRequest::registrationSuccessful,
            this, [&]()
    {
        AppNavigationController::instance().enterPage(AppNavigation::PageID::LoginPage);
        AppNavigationController::instance().openPopup(AppNavigation::PopupID::SuccessPopup, {
                                                          {"message", tr("Account has been created.")}
                                                      });
    });
    connect(request.data(), &RegisterRequest::registerError,
            this, [&](const QString& errorMessage)
    {
        AppNavigationController::instance().openPopup(AppNavigation::PopupID::ErrorPopup, {
                                                          {"errorMessage", errorMessage}
                                                      });
    });

    m_apiClient->send(request);
}

void Session::getProjectsData() const
{
    if (m_apiClient.isNull()) {
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

    m_apiClient->send(request);
}

void Session::getWorkData(const int projectId, const int taskId) const
{
    if (m_apiClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<WorkDataRequest>::create(projectId, taskId, getToken());
    connect(request.data(), &WorkDataRequest::workDataReply,
            this, &Session::workDataReceived);
    connect(request.get(), &WorkDataRequest::workDataError,
            this, [&](const QString &message)
    {
        const QString errorMessage = tr("Could not get information about submitted work.") + "\n" + message;

        AppNavigationController::instance().openPopup(AppNavigation::PopupID::ErrorPopup, {
                                                          {"errorMessage", errorMessage}
                                                      });
    });

    m_apiClient->send(request);
}

void Session::getUserInfo() const
{
    if (m_apiClient.isNull()) {
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

    m_apiClient->send(request);
}

void Session::joinProject(const int projectId) const
{
    if (m_apiClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<JoinProjectRequest>::create(projectId, getToken());
    connect(request.data(), &JoinProjectRequest::joinProjectReply,
            this, &Session::joinRequestSent);
    connect(request.data(), &JoinProjectRequest::joinProjectError,
            this, [&]()
    {
        AppNavigationController::instance().openPopup(AppNavigation::PopupID::ErrorPopup, {
                                                          {"errorMessage", tr("Couldn't join the project. Try again.")}
                                                      });
    });

    m_apiClient->send(request);
}

void Session::getTransactionsData() const
{
    if (m_apiClient.isNull()) {
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

    m_apiClient->send(request);
}

void Session::getWalletBalance() const
{
    if (m_apiClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<WalletBalanceRequest>::create(getToken());
    connect(request.data(), &WalletBalanceRequest::walletBalanceReply,
            this, &Session::walletBalanceReceived);

    m_apiClient->send(request);
}

void Session::getWalletQRCode() const
{
    if (m_apiClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<WalletQRCodeRequest>::create(getToken());
    connect(request.data(), &WalletQRCodeRequest::walletQRCodeReply,
            this, &Session::walletQRCodeReceived);

    m_apiClient->send(request);
}

void Session::getFacilitatorList() const
{
    if (m_apiClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<FacilitatorListRequest>::create(getToken());
    connect(request.data(), &FacilitatorListRequest::facilitatorListReply,
            this, &Session::facilitatorListReceived);

    m_apiClient->send(request);
}

void Session::cashOut(const QString &amount, const QString &phone) const
{
    if (m_apiClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<CashOutRequest>::create(amount, phone, getToken());
    connect(request.data(), &CashOutRequest::transferReply,
            this, &Session::onCashOutReplyReceived);

    m_apiClient->send(request);
}

void Session::facilitatorCashOut(const QString &amount, int facilitatorId) const
{
    if (m_apiClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<FacilitatorCashOutRequest>::create(amount, facilitatorId, getToken());
    connect(request.data(), &FacilitatorCashOutRequest::transferReply,
            this, &Session::onCashOutReplyReceived);

    m_apiClient->send(request);
}

void Session::getProjectDetails(const int projectId) const
{
    if (m_apiClient.isNull()) {
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

    m_apiClient->send(request);
}

void Session::downloadPhoto(const QString &fileName, const int workId) const
{
    if (m_apiClient.isNull()) {
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

    m_apiClient->send(request);
}

void Session::sendWorkRequest(const int projectId, const int taskId, const QVariantMap &requiredData)
{
    if (m_apiClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto activityData = requiredData.value(QLatin1String("data")).toMap();
    auto activityPhotos = requiredData.value(QLatin1String("photos")).toStringList();
    auto job = new SendWorkJob(m_apiClient, projectId, taskId, activityData, activityPhotos, getToken());

    connect(job, &SendWorkJob::finished,
            this, [&](const QString &taskName, const QString &projectName)
    {
        AppNavigationController::instance().openPopup(AppNavigation::PopupID::WorkSuccessPopup, {
                                                          {"taskName", taskName},
                                                          {"projectName", projectName}
                                                      });
        emit sendWorkJobFinished();
    });
    connect(job, &SendWorkJob::failed,
            this, [&](const QString &errorMessage)
    {
        const QString message = tr("Uploading work details failed.") + "\n" + errorMessage;

        AppNavigationController::instance().openPopup(AppNavigation::PopupID::ErrorPopup, {
                                                          {"errorMessage", message}
                                                      });
        emit sendWorkJobFinished();
    });

    connect(job, &SendWorkJob::finished, job, &SendWorkJob::deleteLater);
    connect(job, &SendWorkJob::failed, job, &SendWorkJob::deleteLater);

    job->startJob();
}

void Session::saveUserInfo(const QString &firstName, const QString &lastName, const QString &phone, const QString &village) const
{
    if (m_apiClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<SaveUserInfoRequest>::create(firstName, lastName,
                                                               phone, village, getToken());
    connect(request.data(), &SaveUserInfoRequest::userInfoReply,
            this, &Session::onUserInfo);
    connect(request.data(), &SaveUserInfoRequest::saveUserInfoResult,
            this, [&](const bool result)
    {
        if (result) {
            AppNavigationController::instance().openPopup(AppNavigation::PopupID::SuccessPopup, {
                                                              {"message", tr("Changes saved successfuly")}
                                                          });
        } else {
            AppNavigationController::instance().openPopup(AppNavigation::PopupID::ErrorPopup, {
                                                              {"errorMessage", tr("Couldn't save changes. Try again.")}
                                                          });
        }
    });

    m_apiClient->send(request);
}

void Session::changePassword(const QString &oldPassword, const QString &newPassword) const
{
    if (m_apiClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<ChangePasswordRequest>::create(oldPassword, newPassword, getToken());
    connect(request.data(), &ChangePasswordRequest::changePasswordResult,
            this, [&](const bool result)
    {
        if (result) {
            AppNavigationController::instance().openPopup(AppNavigation::PopupID::SuccessPopup, {
                                                              {"message", tr("Password changed successfuly")}
                                                          });
        } else {
            AppNavigationController::instance().openPopup(AppNavigation::PopupID::ErrorPopup, {
                                                              {"errorMessage", tr("Couldn't change password. Try again.")}
                                                          });
        }
    });

    m_apiClient->send(request);
}

void Session::resetPassword(const QString &email) const
{
    if (m_apiClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    auto request = QSharedPointer<ResetPasswordRequest>::create(email);
    connect(request.data(), &ResetPasswordRequest::passwordResetResult,
            this, &Session::onResetPasswordResult);

    m_apiClient->send(request);
}

void Session::getMyTasks(const QVariantList &taskIds) const
{
    if (m_apiClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if (taskIds.isEmpty()) {
        return;
    }

    auto request = QSharedPointer<MyTasksRequest>::create(taskIds, getToken());
    connect(request.get(), &MyTasksRequest::myTasksReceived,
            m_dataManager, &DataManager::myTasksReceived);

    m_apiClient->send(request);
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

void Session::onCashOutReplyReceived(const bool result)
{
    if (result) {
        AppNavigationController::instance().openPopup(AppNavigation::PopupID::SuccessPopup, {
                                                          {"message", tr("Cashed out successfully.")}
                                                      });
    } else {
        AppNavigationController::instance().openPopup(AppNavigation::PopupID::ErrorPopup, {
                                                          {"errorMessage", tr("Cash out request failed.")}
                                                      });
    }
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
    m_currentUser->clear();
    m_dataManager->cleanData();
    setRememberMe(0);
    setToken(QByteArray());

    AppNavigationController::instance().replaceAllPages(AppNavigation::PageID::LoginPage);
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
