import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle{
    id: headerContainer
    height: 60
    width: parent.width

    property bool backButtonVisible: true
    property string title: ""

    Rectangle {
        height: 20
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        IconButton {
            id: backButton
            anchors.left: parent.left
            iconSrc: ""
            anchors.verticalCenter: parent.verticalCenter
            visible: backButtonVisible
        }

        Label {
            text: title
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "#23BC3D"
        }

        IconButton {
            id: menuButton
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            iconSrc: ""
            onClicked: menu.open()
        }
    }

    Rectangle{
        anchors.bottom: headerContainer.bottom
        height: 2
        width: parent.width
        color: "#E2E9F0"
    }
}
