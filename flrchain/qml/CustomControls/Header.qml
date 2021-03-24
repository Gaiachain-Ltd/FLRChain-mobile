import QtQuick 2.15
import QtQuick.Controls 2.15
import com.flrchain.style 1.0
import QtQuick.Layouts 1.15


ColumnLayout{

    property bool backButtonVisible: true
    property string title: ""

    Rectangle{
        id: headerContainer
        height: 60
        width: parent.width

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
                onClicked: {
                    menu.open()
                    session.getUserInfo()
                }
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

    Label {
        text: qsTr("No Internet Connection")
        Layout.alignment: Qt.AlignHCenter
        Layout.bottomMargin: 5
        color: Style.errorColor
        visible: !session.internetConnection
    }
}
