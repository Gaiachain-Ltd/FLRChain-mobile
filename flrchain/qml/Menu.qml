import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

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
        color: "white"
        radius: 10

        Rectangle {
            color: "white"
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
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            RowLayout{
                id: row
                Layout.leftMargin: 20
                Layout.topMargin: 20

                Label {
                    id:username
                    text: qsTr("UserName")
                    font.pixelSize: 20
                    color: "#23BC3D"
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
                Layout.leftMargin: 20
                text: qsTr("UserEmail")
                font.pixelSize: 14
                color: "#606C83"
                font.weight: Font.DemiBold
            }

            Rectangle {
                color: "#EDEEF2"
                Layout.preferredHeight: 2
                Layout.fillWidth: true
                Layout.leftMargin: -20
                Layout.rightMargin: -20
                Layout.topMargin: 20
            }

            Custom.ImageButton{
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: buttonHeight
                bgColor: "transparent"
                textColor: "#778699"
                text: qsTr("Home")
                iconSrc: ""
                onClicked: {
                }
            }

            Rectangle {
                color: "#EDEEF2"
                Layout.preferredHeight: 1
                Layout.fillWidth: true
            }

            Custom.ImageButton{
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: buttonHeight
                bgColor: "transparent"
                textColor: "#778699"
                text: qsTr("Earn rewards")
                iconSrc: ""

                onClicked: {
                }
            }

            Rectangle {
                color: "#EDEEF2"
                Layout.preferredHeight: 1
                Layout.fillWidth: true
            }

            Custom.ImageButton{
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: buttonHeight
                bgColor: "transparent"
                textColor: "#778699"
                text: qsTr("Wallet")
                iconSrc: ""

                onClicked: {
                }
            }

            Rectangle {
                color: "#EDEEF2"
                Layout.preferredHeight: 1
                Layout.fillWidth: true
            }

            Custom.ImageButton{
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: buttonHeight
                bgColor: "transparent"
                textColor: "#FE2121"
                text: qsTr("Log out")
                iconSrc: ""

                onClicked: {
                }
            }
        }
    }
}
