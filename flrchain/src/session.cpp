#include "session.h"
#include "user.h"
#include "restapiclient.h"
#include "requests/registerrequest.h"
#include "requests/loginrequest.h"
#include "requests/projectsdatarequest.h"
#include "requests/workdatarequest.h"
#include "requests/userinforequest.h"
#include "requests/joinprojectrequest.h"
#include "requests/transactionhistoryrequest.h"
#include "requests/walletbalancerequest.h"
#include "requests/cashoutrequest.h"

#include <QSharedPointer>
#include <QLoggingCategory>
#include <QDebug>
#include "settings.h"
#include "datamanager.h"


Q_LOGGING_CATEGORY(session, "core.session")

Session::Session(QObject *parent) : QObject(parent)
{
    mCurrentUser = UserPtr::create();
    connect(this, &Session::clientInitialized,
            this, &Session::loadData);
}

Session::~Session()
{

}

void Session::setClient(RestAPIClient *client)
{
    mClient = client;
    emit clientInitialized();
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
    getUserInfo();
    getProjectsData();
    emit loginSuccessful(token);
}

void Session::onUserInfo(const QString &firstName, const QString &lastName,
                         const QString &email)
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

void Session::registerUser(const QString& email, const QString& password)
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    auto request = QSharedPointer<RegisterRequest>::create(email, password);
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
            m_dataManager, &DataManager::projectsDataReceived);

    mClient->send(request);
}

void Session::getWorkData() const
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<WorkDataRequest>::create(getToken());
    connect(request.data(), &WorkDataRequest::workDataReply,
            m_dataManager, &DataManager::workDataReceived);

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
            this, &Session::projectJoined);

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
    connect(request.data(), &TransactionHistoryRequest::projectsDataReply,
            m_dataManager, &DataManager::transactionsDataReceived);

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
            m_dataManager, &DataManager::setWalletBalance);

    mClient->send(request);
}

void Session::cashOut(const double amount, const QString& address) const
{
    if (mClient.isNull()) {
        qCDebug(session) << "Client class not set - cannot send request!";
        return;
    }

    if(!hasToken()) {
        qCDebug(session) << "Token is not set";
        return;
    }

    auto request = QSharedPointer<CashOutRequest>::create(amount, address, getToken());
    connect(request.data(), &CashOutRequest::transferReply,
            m_dataManager, &DataManager::cashOutReplyReceived);
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
}

void Session::logout()
{
    mCurrentUser->clear();
    m_dataManager->cleanData();
    setRememberMe(0);
    setToken(QByteArray());
}

void Session::loadData()
{
    if(hasToken()){
        getUserInfo();
        getProjectsData();
    }
}

