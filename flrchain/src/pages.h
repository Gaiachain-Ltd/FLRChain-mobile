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
       WalletScreen
    }; // enum Page

    Q_ENUM(Page)

}; // class Pages

Q_DECLARE_METATYPE(Pages::Page)

#endif // PAGES_H

