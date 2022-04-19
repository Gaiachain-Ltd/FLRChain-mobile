#ifndef APPNAVIGATIONDATA_H
#define APPNAVIGATIONDATA_H

#include <QHash>
#include <QUrl>

namespace AppNavigation
{
    Q_NAMESPACE

    enum class PageID
    {
        LoginPage,
        RegistrationPage,
        ForgotPasswordPage,
        DashboardPage,
        ProjectListPage,
        ProjectDetailsPage,
        WorkPage,
        WalletPage,
        CashOutPage,
        ReceiveMoneyPage,
        ProfilePage,
        
        InvalidPage = -1 // DO NOT MODIFY THIS VALUE
    };
    Q_ENUM_NS(PageID)

    static const QHash<PageID, QUrl> pageUrls =
    {
        { PageID::LoginPage, QUrl("qrc:/LoginScreen.qml") },
        { PageID::RegistrationPage, QUrl("qrc:/RegistrationScreen.qml") },
        { PageID::ForgotPasswordPage, QUrl("qrc:/ForgotPasswordScreen.qml") },
        { PageID::DashboardPage, QUrl("qrc:/Dashboard.qml") },
        { PageID::ProjectListPage, QUrl("qrc:/ProjectListScreen.qml") },
        { PageID::ProjectDetailsPage, QUrl("qrc:/ProjectDetailsScreen.qml") },
        { PageID::WorkPage, QUrl("qrc:/WorkScreen.qml") },
        { PageID::WalletPage, QUrl("qrc:/WalletScreen.qml") },
        { PageID::CashOutPage, QUrl("qrc:/CashOutPage.qml") },
        { PageID::ReceiveMoneyPage, QUrl("qrc:/ReceiveMoneyPage.qml") },
        { PageID::ProfilePage, QUrl("qrc:/ProfileScreen.qml") }
    };

    enum class PopupID
    {
        SuccessPopup,
        ErrorPopup,
        ConfirmLogoutPopup,
        JoinProjectPopup,
        WorkSuccessPopup,
        ChangePasswordPopup,
        
        InvalidPopup = -1 // DO NOT MODIFY THIS VALUE
    };
    Q_ENUM_NS(PopupID)

    static const QHash<PopupID, QUrl> popupUrls =
    {
        { PopupID::SuccessPopup, QUrl("qrc:/Popups/SuccessPopup.qml") },
        { PopupID::ErrorPopup, QUrl("qrc:/Popups/ErrorPopup.qml") },
        { PopupID::ConfirmLogoutPopup, QUrl("qrc:/Popups/ConfirmLogoutPopup.qml") },
        { PopupID::JoinProjectPopup, QUrl("qrc:/Popups/JoinProjectPopup.qml") },
        { PopupID::WorkSuccessPopup, QUrl("qrc:/Popups/WorkSuccessPopup.qml") },
        { PopupID::ChangePasswordPopup, QUrl("qrc:/Popups/ChangePasswordPopup.qml") }
    };

    inline uint qHash(const PageID &pageId, uint seed)
    {
        return ::qHash(static_cast<typename std::underlying_type<PageID>::type>(pageId), seed);
    }

    inline uint qHash(const PopupID &popupId, uint seed)
    {
        return ::qHash(static_cast<typename std::underlying_type<PopupID>::type>(popupId), seed);
    }
};

#endif // APPNAVIGATIONDATA_H
