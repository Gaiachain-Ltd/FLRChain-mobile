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
        ConfirmCashOutPopup,
        CashOutSuccessPopup,
        
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
        { PopupID::ChangePasswordPopup, QUrl("qrc:/Popups/ChangePasswordPopup.qml") },
        { PopupID::ConfirmCashOutPopup, QUrl("qrc:/Popups/ConfirmCashOutPopup.qml") },
        { PopupID::CashOutSuccessPopup, QUrl("qrc:/Popups/CashOutSuccessPopup.qml") }
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
