import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: mainWindow
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    onClosing: {
        close.accepted = false;
        if (stack.depth > 1) {
            stack.pop();
        }
        else {
            Qt.quit()
        }
    }


    Menu{
        id: menu
    }


    PagesView {
        id: stack
        anchors.fill: parent

        Component.onCompleted: {
            if(session.hasToken() && session.getRememberMe()){
                stack.pushPage("qrc:/Dashboard.qml");
            }
            else{
                stack.pushPage("qrc:/LoginScreen.qml");
            }
        }
    }
}
