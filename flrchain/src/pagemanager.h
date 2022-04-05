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

#ifndef PAGEMANAGER_H
#define PAGEMANAGER_H

#include <QObject>
#include <QVector>

#include "pages.h"

class PageManager : public QObject
{
    Q_OBJECT

public:
    static PageManager *instance();
    static void dealloc();

    PageManager(const PageManager &) = delete;
    Q_INVOKABLE bool isPageOnTop(int page) const;
    Q_INVOKABLE bool isPageOpened(Pages::Page page) const;
    void enterPage(Pages::Page page);

    Q_INVOKABLE bool back();
    Q_INVOKABLE bool backTo(Pages::Page page);

    Q_INVOKABLE bool enterLoginScreen();
    Q_INVOKABLE bool enterRegistrationScreen();
    Q_INVOKABLE bool enterDashboardScreen();
    Q_INVOKABLE bool enterProjectListScreen();
    Q_INVOKABLE bool enterProjectDetailsScreen(const int projectId);
    Q_INVOKABLE bool enterWorkScreen(const QVariantMap &taskData);
    Q_INVOKABLE bool enterWalletScreen();
    Q_INVOKABLE bool enterCashOutScreen(const Pages::CashOutPageMode cashOutMode, double maxAmount);
    Q_INVOKABLE bool enterReceiveMoneyPage(const QUrl &qrCodeUrl);
    Q_INVOKABLE bool enterProfileScreen();
    Q_INVOKABLE bool enterForgotPasswordScreen();
    Q_INVOKABLE void closeAll();
    Q_INVOKABLE bool enterErrorPopup(const QString &errorMessage) const;
    Q_INVOKABLE bool enterSuccessPopup(const QString &message) const;

signals:
    void pushPage(Pages::Page page) const;
    void popPage(int page) const;
    void clearStack() const;

    // Page setups
    void setupProjectDetailsScreen(const int projectId);
    void setupWorkScreen(const QVariantMap &taskData);
    void setupCashOutScreen(const Pages::CashOutPageMode cashOutMode, double maxAmount);
    void setupReceiveMoneyScreen(const QUrl &qrCodeUrl);
    void setupErrorPopup(const QString &errorMsg) const;
    void setupSuccessPopup(const QString &message) const;

    void backTriggered();
    void beforePopBack();

private:
    PageManager();
    static PageManager *m_instance;
    QVector<Pages::Page> m_visiblePages;
};

#endif // PAGEMANAGER_H
