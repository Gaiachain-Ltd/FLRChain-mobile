import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import com.flrchain.objects 1.0
import "qrc:/Popups" as Popups

ApplicationWindow {
    id: mainWindow
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    onClosing: {
        close.accepted = false;
        pageManager.back()
    }

    Menu{
        id: menu
    }

    PagesView {
        id: stack
        anchors.fill: parent

        Component.onCompleted: {
            if(session.hasToken() && session.getRememberMe()){
                pageManager.enterDashboardScreen()
            }
            else{
                pageManager.enterLoginScreen()
            }
        }
    }

    Connections
    {
        target: pageManager

        function onPushPage(page)
        {
            switch (page)
            {
            case Pages.LoginScreen:
                stack.push("qrc:/LoginScreen.qml");
                break;
            case Pages.RegistrationScreen:
                stack.push("qrc:/RegistrationScreen.qml");
                break;
            case Pages.Dashboard:
                stack.push("qrc:/Dashboard.qml");
                break;
            case Pages.ProjectListScreen:
                stack.push("qrc:/ProjectListScreen.qml");
                break;
            case Pages.ProjectDetailsScreen:
                stack.push("qrc:/ProjectDetailsScreen.qml")
                break;
            case Pages.WorkScreen:
                stack.push("qrc:/WorkScreen.qml");
                break;
            case Pages.WalletScreen:
                stack.push("qrc:/WalletScreen.qml");
                break;
            }
        }

        function onPopPage()
        {
            if (stack.depth > 1) {
                stack.pop();
            }
            else {
                Qt.quit()
            }
        }

        function onClearStack()
        {
            stack.clear()
        }

        function onSetupErrorPopup(errorMessage)
        {
            errorPopup.errorMessage = errorMessage;
            errorPopup.open();
        }

        function onSetupSuccessPopup(message)
        {
            successPopup.message = message;
            successPopup.open();
        }
    }

    Popups.ErrorPopup{
        id: errorPopup

    }

    Popups.ConfirmLogoutPopup{
        id: logoutPopup
    }

    Popups.SuccessPopup {
        id: successPopup
    }
}
