import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "qrc:/CustomControls" as Custom

Item {

    Custom.Header {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        backButtonVisible: false
        title: qsTr("Dashboard")
    }

    Rectangle {
        id: background
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        ColumnLayout {
            anchors.fill: parent
            anchors.topMargin: 30
            anchors.bottomMargin: 170
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            spacing: 40

            Custom.ShadowedRectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: 223
                Layout.fillWidth: true

                Rectangle{
                    anchors.fill: parent
                    radius: 10
                    color: "white"

                    RowLayout{
                        id: row
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: 20

                        Label {
                            text: "Earn rewards"
                            font.pixelSize: 22
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
                            onClicked: stack.pushPage("qrc:/ProjectListScreen.qml");
                        }
                    }

                    Label {
                        anchors.top: row.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        text: "4 projects"
                        font.pixelSize: 14
                        color: "#778699"
                        font.weight: Font.DemiBold
                    }

                    Rectangle{
                        anchors.bottom: parent.bottom
                        radius: 10
                        height: 90
                        width: parent.width
                        color: "white"
                    }
                }
            }

            Custom.ShadowedRectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: 223
                Layout.fillWidth: true

                Rectangle{
                    anchors.fill: parent
                    radius: 10
                    color: "#FFFCE2"

                    RowLayout{
                        id: contentRow
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: 20

                        Label {
                            text: "Wallet"
                            font.pixelSize: 22
                            color: "#FFC423"
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
                            onClicked: {
                            }
                        }
                    }

                    Label {
                        anchors.top: contentRow.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        text: "Balance: 321 USDC"
                        font.pixelSize: 14
                        color: "#778699"
                        font.weight: Font.DemiBold
                    }

                    Rectangle{
                        anchors.bottom: parent.bottom
                        height: 90
                        radius: 10
                        width: parent.width
                        color: "transparent"
                    }
                }
            }
        }
    }
}
