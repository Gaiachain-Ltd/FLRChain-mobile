/*
 * Copyright (C) 2022  Milo Solutions
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

import com.flrchain.style 1.0
import com.flrchain.objects 1.0
import com.milosolutions.AppNavigation 1.0
import com.melije.pulltorefresh 2.0

import "qrc:/AppNavigation"
import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates
import "qrc:/Popups" as Popups

AppPage {
    id: root

    property double walletBalance: 0.0

    Custom.BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        visible: false
    }

    Component.onCompleted: {
        reloadData()
    }

    function reloadData() {
        busyIndicator.visible = true
        session.getWalletBalance()
        session.getTransactionsData()
    }

    Connections {
        target: session

        function onWalletBalanceReceived(balance) {
            walletBalance = balance
        }
    }

    Connections {
        target: transactionsModel

        function onTransactionsReceived() {
            busyIndicator.visible = false
        }
    }

    Connections {
        target: platform

        function onScannerReady() {
            AppNavigationController.enterPage(AppNavigation.SendMoneyPage,
                                              {
                                                  maxAmount: root.walletBalance,
                                                  state: "ScanCodeState"
                                              })
        }
    }

    background: null

    header: Custom.Header {
        height: Style.headerHeight
        title: qsTr("Wallet")
    }

    Flickable {
        id: walletFlickable
        anchors.fill: parent
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.DragOverBounds
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
                        AppNavigationController.enterPage(AppNavigation.CashOutPage,
                                                          {
                                                              maxAmount: root.walletBalance,
                                                              state: "LoadingState"
                                                          })
                    }
                }

                Custom.PrimaryButton {
                    Layout.fillWidth: true
                    icon.source: "qrc:/img/icon-mobile-money.svg"
                    icon.color: labelColor
                    text: qsTr("Mobile money")

                    onClicked: {
                        AppNavigationController.enterPage(AppNavigation.CashOutPage,
                                                          {
                                                              maxAmount: root.walletBalance,
                                                              state: "SendToMobileNumberState"
                                                          })
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
                        AppNavigationController.enterPage(AppNavigation.ReceiveMoneyPage)
                    }
                }

                Custom.PrimaryButton {
                    Layout.fillWidth: true
                    icon.source: "qrc:/img/icon-send.svg"
                    icon.color: labelColor
                    text: qsTr("Send USDC")

                    onClicked: {
                        platform.scan();
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
                        transactionProjectName: title
                        transactionType: action
                        transactionAmount: amount
                        transactionNote: note
                        separatorVisible: index !== listView.count - 1
                    }
                }
            }
        }

        PullToRefreshHandler {
            target: walletFlickable
            threshold: 25
            refreshIndicatorDelegate: RefreshIndicator {
                Material.accent: Style.accentColor
            }

            onPullDownRelease:
            {
                reloadData()
            }
        }
    }
}
