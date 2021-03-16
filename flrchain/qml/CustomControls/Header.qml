import QtQuick 2.15
import QtQuick.Controls 2.15
import com.flrchain.style 1.0

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
        anchors.leftMargin: Style.baseMargin
        anchors.rightMargin: Style.baseMargin

        IconButton {
            id: backButton
            anchors.left: parent.left
            iconSrc: "qrc:/img/icon-back.svg"
            anchors.verticalCenter: parent.verticalCenter
            visible: backButtonVisible
            onClicked: pageManager.back()
            width: 26
            height: 26
            iconSize: Style.iconSize
        }

        Label {
            text: title
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: Style.accentColor
        }

        IconButton {
            id: menuButton
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            iconSrc: "qrc:/img/icon-menu.svg"
            onClicked: menu.open()
            width: 26
            height: 26
            iconSize: 26
        }
    }

    Rectangle{
        anchors.bottom: headerContainer.bottom
        height: 2
        width: parent.width
        color: Style.grayBgColor
    }
}
