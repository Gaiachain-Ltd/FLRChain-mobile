import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Item {
    property double walletBalance: 0.0
    property int projectsCount: 0

    Component.onCompleted: {
        session.getWalletBalance()
        session.getProjectsData()
    }

    Connections{
        target: dataManager

        function onWalletBalanceReceived(balance) {
            walletBalance = balance
        }

        function onProjectsReceived(projects){
            projectsCount = projects.length
        }
    }

    Custom.Header {
        id: header
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        backButtonVisible: false
        title: qsTr("Dashboard")
    }

    Rectangle {
        id: background
        anchors {
            top: header.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        ColumnLayout {
            anchors {
                fill: parent
                topMargin: Style.bigMargin
                bottomMargin: 170
                leftMargin: Style.smallMargin
                rightMargin: Style.smallMargin
            }
            spacing: Style.ultraMargin

            Custom.ShadowedRectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: Style.dashboardDelegateHeight
                Layout.fillWidth: true

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        pageManager.enterProjectListScreen()
                    }
                }

                Rectangle{
                    anchors.fill: parent
                    radius: Style.rectangleRadius
                    color: Style.bgColor

                    RowLayout{
                        id: row
                        anchors {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                            leftMargin: Style.baseMargin
                            topMargin: Style.baseMargin
                        }

                        Label {
                            text: qsTr("Earn rewards")
                            font.pixelSize: Style.fontUltra
                            color: Style.accentColor
                        }

                        Item{
                            Layout.fillWidth: true
                            Layout.preferredHeight: Style.iconBig
                        }

                        Custom.IconButton {
                            iconSize: Style.iconBig
                            iconSrc: "qrc:/img/dashboard-arrow-green.svg"
                            onClicked: {
                                pageManager.enterProjectListScreen()
                            }
                        }
                    }

                    Label {
                        anchors {
                            top: row.bottom
                            left: parent.left
                            leftMargin: Style.baseMargin
                        }
                        text: qsTr("%1 projects").arg(projectsCount)
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
                Layout.preferredHeight: Style.dashboardDelegateHeight
                Layout.fillWidth: true

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        pageManager.enterWalletScreen()
                    }
                }

                Rectangle{
                    anchors.fill: parent
                    radius: Style.rectangleRadius
                    color: Style.yellowDelegateColor

                    RowLayout{
                        id: contentRow
                        anchors {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                            leftMargin: Style.baseMargin
                            topMargin: Style.baseMargin
                        }
                        Label {
                            text: qsTr("Wallet")
                            font.pixelSize: Style.fontUltra
                            color: Style.yellowLabelColor
                        }

                        Item{
                            Layout.fillWidth: true
                            Layout.preferredHeight: Style.iconBig
                        }

                        Custom.IconButton {
                            iconSize: Style.iconBig
                            iconSrc: "qrc:/img/dashboard-arrow-yellow.svg"
                            onClicked:{
                                pageManager.enterWalletScreen()
                            }
                        }
                    }

                    Label {
                        anchors {
                            top: contentRow.bottom
                            left: parent.left
                            leftMargin: Style.baseMargin
                        }
                        text: qsTr("Balance: %1 USDC").arg(walletBalance)
                        font.pixelSize: Style.fontSmall
                        color: Style.baseLabelColor
                        font.weight: Font.DemiBold
                    }

                    Image {
                        source: "qrc:/img/dashboard-wallet.svg"
                        width: 190
                        height: 100
                        sourceSize: Qt.size(width, height)
                        anchors {
                            bottom: parent.bottom
                            horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }
    }
}
