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
    Q_INVOKABLE bool enterWorkScreen(const int projectId, const int taskId, const QString &projectName, const QString &taskName);
    Q_INVOKABLE bool enterWalletScreen();
    Q_INVOKABLE bool enterCashOutScreen(const Pages::CashOutPageMode cashOutMode);
    Q_INVOKABLE bool enterReceiveMoneyPage(const QUrl &qrCodeUrl);
    Q_INVOKABLE void closeAll();
    Q_INVOKABLE bool enterErrorPopup(const QString &errorMessage) const;
    Q_INVOKABLE bool enterSuccessPopup(const QString &message) const;

signals:
    void pushPage(Pages::Page page) const;
    void popPage(int page) const;
    void clearStack() const;

    // Page setups
    void setupProjectDetailsScreen(const int projectId);
    void setupWorkScreen(const int projectId, const int taskId, const QString &projectName, const QString &taskName);
    void setupCashOutScreen(const Pages::CashOutPageMode cashOutMode);
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
