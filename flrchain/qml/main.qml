import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.4

ApplicationWindow {
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    Loader {
        id: page
        anchors.fill: parent
        source: "qrc:/LoginScreen.qml"
    }
}
