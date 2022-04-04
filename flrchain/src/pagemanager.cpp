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

#include "pagemanager.h"

#include <QDebug>

PageManager *PageManager::m_instance = Q_NULLPTR;

PageManager *PageManager::instance()
{
    if (!m_instance) {
        m_instance = new PageManager();
    }
    return m_instance;
}

void PageManager::dealloc()
{
    if (m_instance) {
        delete m_instance;
        m_instance = Q_NULLPTR;
    }
}

PageManager::PageManager()
{
}

bool PageManager::isPageOnTop(int page) const
{
    if (m_visiblePages.empty()) {
        return false;
    }

    return m_visiblePages.back() == page;
}

void PageManager::enterPage(Pages::Page page)
{
    if(isPageOpened(page)){
        backTo(page);
        return;
    }
    m_visiblePages.push_back(page);

    emit pushPage(page);
    qDebug() << "Pages" << m_visiblePages;
}

bool PageManager::isPageOpened(Pages::Page page) const
{
    return m_visiblePages.contains(page);
}

bool PageManager::back()
{
    emit beforePopBack();
    if (m_visiblePages.size() > 0) {
        Pages::Page p = m_visiblePages.back();

        emit popPage(p);
        m_visiblePages.pop_back();
        qDebug() << "Page stack after Pop: " << m_visiblePages;
    }
    emit backTriggered();
    return true;
}

bool PageManager::backTo(Pages::Page page)
{
    if (isPageOpened(page)) {
        while (!isPageOnTop(page)) {
            back();
        }
    }

    return true;
}

bool PageManager::enterLoginScreen()
{
    enterPage(Pages::LoginScreen);
    return true;
}

bool PageManager::enterRegistrationScreen()
{
    enterPage(Pages::RegistrationScreen);
    return true;
}

bool PageManager::enterDashboardScreen()
{
    if(isPageOnTop(Pages::LoginScreen)){
       closeAll();
    }

    enterPage(Pages::Dashboard);
    return true;
}

bool PageManager::enterProjectListScreen()
{
    enterPage(Pages::ProjectListScreen);
    return true;
}

bool PageManager::enterProjectDetailsScreen(const int projectId)
{
    enterPage(Pages::ProjectDetailsScreen);
    emit setupProjectDetailsScreen(projectId);
    return true;
}

bool PageManager::enterWorkScreen(const int projectId, const int taskId, const QString &projectName, const QString &taskName)
{
    enterPage(Pages::WorkScreen);
    emit setupWorkScreen(projectId, taskId, projectName, taskName);
    return true;
}

bool PageManager::enterWalletScreen()
{
    enterPage(Pages::WalletScreen);
    return true;
}

bool PageManager::enterCashOutScreen(const Pages::CashOutPageMode cashOutMode, double maxAmount)
{
    enterPage(Pages::CashOutScreen);
    emit setupCashOutScreen(cashOutMode, maxAmount);
    return true;
}

bool PageManager::enterReceiveMoneyPage(const QUrl &qrCodeUrl)
{
    enterPage(Pages::ReceiveMoneyScreen);
    emit setupReceiveMoneyScreen(qrCodeUrl);
    return true;
}

bool PageManager::enterProfileScreen()
{
    enterPage(Pages::ProfileScreen);
    return true;
}

void PageManager::closeAll()
{
    m_visiblePages.clear();
    emit clearStack();
}

bool PageManager::enterErrorPopup(const QString &errorMessage) const
{
    emit setupErrorPopup(errorMessage);
    return true;
}

bool PageManager::enterSuccessPopup(const QString &message) const
{
    emit setupSuccessPopup(message);
    return true;
}
