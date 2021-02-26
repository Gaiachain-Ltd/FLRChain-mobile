import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
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

    PagesView {
        id: stack
        anchors.fill: parent

        Component.onCompleted: {
            stack.pushPage("qrc:/WorkScreen.qml");
        }
    }
}
