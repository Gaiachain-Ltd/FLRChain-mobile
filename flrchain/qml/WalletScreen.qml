import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0
import com.flrchain.objects 1.0

import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates
import "qrc:/Popups" as Popups

Page {
    id: root

    property double walletBalance: 0.0

    Custom.BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        visible: false
    }

    Component.onCompleted: {
        busyIndicator.visible = true
        session.getWalletBalance()
        session.getTransactionsData()
    }

    Connections {
        target: dataManager

        function onWalletBalanceReceived(balance) {
            walletBalance = balance
        }
    }

    Connections {
        target: transactionsModel
        function onTransactionsReceived(){
            busyIndicator.visible = false
        }
    }

    Connections {
        target: pageManager
        function onBackTriggered(){
            busyIndicator.visible = true
            session.getWalletBalance()
            session.getTransactionsData()
        }
    }

    background: null

    header: Custom.Header {
        height: Style.headerHeight
        title: qsTr("Wallet")
    }

    Flickable {
        id: flick
        anchors.fill: parent
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        visible: !busyIndicator.visible

        ColumnLayout {
            id: mainColumn
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: Style.walletPagePadding
                rightMargin: Style.walletPagePadding
            }

            Custom.Pane {
                Layout.fillWidth: true
                Layout.topMargin: Style.walletPagePadding
                padding: Style.walletPagePanePadding

                Label {
                    Layout.fillWidth: true
                    horizontalAlignment: Label.AlignHCenter
                    wrapMode: Label.WordWrap
                    font: Style.balanceDelegateTitleFont
                    color: Style.balanceDelegateTitleFontColor
                    text: qsTr("You have")
                }

                Row {
                    Layout.alignment: Qt.AlignHCenter

                    Label {
                        id: valueLabel
                        font: Style.balanceDelegateAmountFont
                        color: Style.balanceDelegateAmountFontColor
                        text: walletBalance
                    }

                    Label {
                        font: Style.balanceDelegateCurrencyFont
                        color: Style.balanceDelegateCurrencyFontColor
                        text: " USDC"
                    }
                }
            }

            Label {
                Layout.topMargin: Style.walletPageSectionSpacing
                font: Style.walletPageSectionTitleFont
                color: Style.walletPageSectionTitleFontColor
                text: qsTr("Cash out")
            }

            Custom.Pane {
                Layout.fillWidth: true
                Layout.topMargin: Style.walletPageTitleSpacing
                padding: Style.walletPagePanePadding
                contentSpacing: Style.walletPagePanePadding

                Custom.PrimaryButton {
                    Layout.fillWidth: true
                    icon.source: "qrc:/img/icon-facilitator.svg"
                    icon.color: labelColor
                    text: qsTr("Facilitator")

                    onClicked: {
                        pageManager.enterCashOutScreen(Pages.FacilitatorCashOutMode)
                    }
                }

                Custom.PrimaryButton {
                    Layout.fillWidth: true
                    icon.source: "qrc:/img/icon-mobile-money.svg"
                    icon.color: labelColor
                    text: qsTr("Mobile money")

                    onClicked: {
                        pageManager.enterCashOutScreen(Pages.MobileNumberCashOutMode)
                    }
                }
            }

            Label {
                Layout.topMargin: Style.walletPageSectionSpacing
                font: Style.walletPageSectionTitleFont
                color: Style.walletPageSectionTitleFontColor
                text: qsTr("Crypto")
            }

            Custom.Pane {
                Layout.fillWidth: true
                Layout.topMargin: Style.walletPageTitleSpacing
                padding: Style.walletPagePanePadding
                contentSpacing: Style.walletPagePanePadding

                Custom.PrimaryButton {
                    Layout.fillWidth: true
                    icon.source: "qrc:/img/icon-receive.svg"
                    icon.color: labelColor
                    text: qsTr("Receive USDC")

                    onClicked: {
                        pageManager.enterReceiveMoneyPage("qrc:/img/qr-example.svg") // TODO
                    }
                }
            }

            Label {
                Layout.topMargin: Style.walletPageSectionSpacing
                font: Style.walletPageSectionTitleFont
                color: Style.walletPageSectionTitleFontColor
                text: qsTr("Transaction history")
            }

            Custom.Pane {
                Layout.fillWidth: true
                Layout.topMargin: Style.walletPageTitleSpacing
                Layout.bottomMargin: Style.walletPagePadding

                ListView {
                    id: listView
                    Layout.fillWidth: true
                    Layout.preferredHeight: contentHeight
                    model: transactionsModel
                    interactive: false

                    section.property: "creationDate"
                    section.delegate: Delegates.TransactionSectionDelegate {
                        width: listView.width
                    }

                    delegate: Delegates.TransactionDelegate {
                        width: listView.width
                        transactionProjectName: "TODO: project name"
                        transactionType: action
                        transactionAmount: amount
                        separatorVisible: index !== listView.count - 1
                    }
                }
            }
        }
    }
}
