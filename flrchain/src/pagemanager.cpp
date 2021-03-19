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
        m_visiblePages.clear();
        emit clearStack();
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
