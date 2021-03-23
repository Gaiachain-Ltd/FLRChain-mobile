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
                        anchors.leftMargin: Style.baseMargin
                        anchors.topMargin: Style.baseMargin

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
                            Layout.preferredWidth: 40
                            Layout.preferredHeight: 40
                            iconSize: 26
                            iconSrc: "qrc:/img/dashboard-arrow-green.svg"
                            onClicked: {
                                pageManager.enterProjectListScreen()
                            }
                        }
                    }

                    Label {
                        anchors.top: row.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: Style.baseMargin
                        text: qsTr("%1 projects").arg(dataManager.projectsCount)
                        font.pixelSize: Style.fontSmall
                        color: Style.baseLabelColor
                        font.weight: Font.DemiBold
                    }

                    Image {
                        source: "qrc:/img/dashboard-earn-rewards.svg"
                        width: parent.width
                        height: 90
                        anchors.bottom: parent.bottom
                        sourceSize: Qt.size(width, height)
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
                        anchors.leftMargin: Style.baseMargin
                        anchors.topMargin: Style.baseMargin

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
                            Layout.preferredWidth: 40
                            Layout.preferredHeight: 40
                            iconSize: 26
                            iconSrc: "qrc:/img/dashboard-arrow-yellow.svg"
                            onClicked: pageManager.enterWalletScreen()
                        }
                    }

                    Label {
                        anchors.top: contentRow.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: Style.baseMargin
                        text: qsTr("Balance: %1 USDC").arg(dataManager.walletBalance)
                        font.pixelSize: Style.fontSmall
                        color: Style.baseLabelColor
                        font.weight: Font.DemiBold
                    }

                    Image {
                        source: "qrc:/img/dashboard-wallet.svg"
                        width: 190
                        height: 100
                        sourceSize: Qt.size(width, height)
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }
}
