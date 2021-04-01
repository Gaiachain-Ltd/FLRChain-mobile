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
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                rightMargin: Style.microMargin
            }

            IconButton {
                id: backButton
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
                iconSrc: "qrc:/img/icon-back.svg"
                visible: backButtonVisible
                onClicked: pageManager.back()
                height: headerContainer.height
                width: height
                iconSize: Style.iconSize
            }

            Label {
                text: title
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                color: Style.accentColor
            }

            IconButton {
                id: menuButton
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                iconSrc: "qrc:/img/icon-menu.svg"
                onClicked: {
                    menu.open()
                    session.getUserInfo()
                }
                height: headerContainer.height
                width: height
                iconSize: Style.iconBig
            }
        }

        Rectangle{
            anchors.bottom: headerContainer.bottom
            height: Style.separatorHeight
            width: parent.width
            color: Style.grayBgColor
        }
    }

    Label {
        text: qsTr("No Internet Connection")
        Layout.alignment: Qt.AlignHCenter
        Layout.bottomMargin: Style.microMargin
        color: Style.errorColor
        visible: !session.internetConnection
    }
}
