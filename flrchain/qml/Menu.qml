import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Drawer {
    id: drawer
    width: parent.width
    edge: Qt.TopEdge
    interactive: false
    property real buttonHeight: 58

    background: Rectangle{
        width: parent.width
        height: contentItem.height
        color: Style.bgColor
        radius: 10

        Rectangle {
            color: Style.bgColor
            anchors.top: parent.top
            width: parent.width
            height: 8
        }
    }

    contentItem: Rectangle {
        width: parent.width
        height: column.height
        radius: 10

        ColumnLayout {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: Style.baseMargin
            anchors.rightMargin: Style.baseMargin

            RowLayout{
                id: row
                Layout.leftMargin: Style.baseMargin
                Layout.topMargin: Style.baseMargin

                Label {
                    id:username
                    text: session.user.firstName + " " + session.user.lastName
                    font.pixelSize: Style.fontLarge
                    color: Style.accentColor
                }

                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 26
                }

                Custom.IconButton {
                    Layout.preferredWidth: 26
                    Layout.preferredHeight: 26
                    iconSize: 26
                    iconSrc: ""
                    onClicked: drawer.close()
                }
            }

            Label {
                id: usermail
                Layout.leftMargin: Style.baseMargin
                text: session.user.email
                font.pixelSize: Style.fontSmall
                color: Style.darkLabelColor
                font.weight: Font.DemiBold
            }

            Rectangle {
                color: Style.sectionColor
                Layout.preferredHeight: 2
                Layout.fillWidth: true
                Layout.leftMargin: -Style.baseMargin
                Layout.rightMargin: -Style.baseMargin
                Layout.topMargin: Style.baseMargin
            }

            Custom.ImageButton{
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: buttonHeight
                bgColor: Style.colorTransparent
                textColor: Style.baseLabelColor
                text: qsTr("Home")
                iconSrc: ""
                onClicked: {
                    drawer.close()
                    pageManager.enterDashboardScreen()
                }
            }

            Rectangle {
                color: Style.sectionColor
                Layout.preferredHeight: 1
                Layout.fillWidth: true
            }

            Custom.ImageButton{
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: buttonHeight
                bgColor: Style.colorTransparent
                textColor: Style.baseLabelColor
                text: qsTr("Earn rewards")
                iconSrc: ""

                onClicked: {
                    drawer.close()
                    pageManager.enterProjectListScreen()
                }
            }

            Rectangle {
                color: Style.sectionColor
                Layout.preferredHeight: 1
                Layout.fillWidth: true
            }

            Custom.ImageButton{
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: buttonHeight
                bgColor: Style.colorTransparent
                textColor: Style.baseLabelColor
                text: qsTr("Wallet")
                iconSrc: ""

                onClicked: {
                    drawer.close()
                    pageManager.enterWalletScreen()
                }
            }

            Rectangle {
                color: Style.sectionColor
                Layout.preferredHeight: 1
                Layout.fillWidth: true
            }

            Custom.ImageButton{
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: buttonHeight
                bgColor: Style.colorTransparent
                textColor: Style.errorColor
                text: qsTr("Log out")
                iconSrc: ""

                onClicked: {
                }
            }
        }
    }
}
