import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

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
            anchors.topMargin: Style.bigMargin
            anchors.bottomMargin: 170
            anchors.leftMargin: Style.baseMargin
            anchors.rightMargin: Style.baseMargin
            spacing: 40

            Custom.ShadowedRectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: 223
                Layout.fillWidth: true

                Rectangle{
                    anchors.fill: parent
                    radius: 10
                    color: Style.bgColor

                    RowLayout{
                        id: row
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: Style.baseMargin

                        Label {
                            text: "Earn rewards"
                            font.pixelSize: Style.fontUltra
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
                            onClicked: stack.pushPage("qrc:/ProjectListScreen.qml");
                        }
                    }

                    Label {
                        anchors.top: row.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: Style.baseMargin
                        text: "4 projects"
                        font.pixelSize: Style.fontSmall
                        color: Style.baseLabelColor
                        font.weight: Font.DemiBold
                    }

                    Rectangle{
                        anchors.bottom: parent.bottom
                        radius: 10
                        height: 90
                        width: parent.width
                        color: Style.bgColor
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
                    color: Style.yellowDelegateColor

                    RowLayout{
                        id: contentRow
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: Style.baseMargin

                        Label {
                            text: "Wallet"
                            font.pixelSize: Style.fontUltra
                            color: Style.yellowLabelColor
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
                            onClicked: stack.pushPage("qrc:/WalletScreen.qml");
                        }
                    }

                    Label {
                        anchors.top: contentRow.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: Style.baseMargin
                        text: "Balance: 321 USDC"
                        font.pixelSize: Style.fontSmall
                        color: Style.baseLabelColor
                        font.weight: Font.DemiBold
                    }

                    Rectangle{
                        anchors.bottom: parent.bottom
                        height: 90
                        radius: 10
                        width: parent.width
                        color: Style.colorTransparent
                    }
                }
            }
        }
    }
}
