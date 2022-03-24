#ifndef PAGES_H
#define PAGES_H

#include <QObject>

class Pages
{
    Q_GADGET

public:
    enum Page {
        LoginScreen,
        RegistrationScreen,
        Dashboard,
        ProjectListScreen,
        ProjectDetailsScreen,
        WorkScreen,
        WalletScreen,
        CashOutScreen,
        ReceiveMoneyScreen
    };

    Q_ENUM(Page)

    enum CashOutPageMode
    {
        FacilitatorCashOutMode,
        MobileNumberCashOutMode
    };

    Q_ENUM(CashOutPageMode)

};

Q_DECLARE_METATYPE(Pages::Page)
Q_DECLARE_METATYPE(Pages::CashOutPageMode)

#endif // PAGES_H

