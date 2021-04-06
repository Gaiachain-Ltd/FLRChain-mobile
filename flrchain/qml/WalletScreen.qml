import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates
import "qrc:/Popups" as Popups

Item {
    property double walletBalance: 0.0

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: true
        visible: false
    }

    Component.onCompleted: {
        busyIndicator.visible = true
        session.getWalletBalance()
        session.getTransactionsData()
    }

    Connections{
        target: dataManager
        function onTransactionsDataReceived(walletList){
            busyIndicator.visible = false

            walletModel.clear()
            for (var i = 0; i < walletList.length; ++i) {
                walletModel.append({amount: walletList[i].amount, creationDate: walletList[i].creationDate,
                                   projectName: walletList[i].title})
            }
        }

        function onWalletBalanceReceived(balance) {
            walletBalance = balance
        }
    }

    ListModel
    {
        id: walletModel
    }

    Connections{
        target: pageManager
        function onBackTriggered(){
            busyIndicator.visible = true
            session.getWalletBalance()
            session.getTransactionsData()
        }
    }

    Custom.Header {
        id: header
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        title: qsTr("Wallet")
    }

    Popups.TransactionPopup{
        id: transactionPopup
    }

    Popups.TransferSuccessPopup{
        id: transferSuccess
    }

    Flickable {
        id: flick
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            topMargin: Style.baseMargin
        }
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        visible: !busyIndicator.visible

        ColumnLayout {
            id: mainColumn
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: Style.smallMargin
                rightMargin: Style.smallMargin
            }
            spacing: Style.baseMargin

            Label {
                text: qsTr("Your account")
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
            }

            Delegates.BalanceDelegate {
                Layout.fillWidth: true
                buttonVisible: true
                title: qsTr("Balance")
                value: walletBalance
                btn.onClicked: {
                    transactionPopup.open()
                }
            }

            Label {
                text: qsTr("Transaction history")
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
            }

            Custom.ShadowedRectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height
                Layout.bottomMargin: Style.baseMargin
                Layout.topMargin: Style.tinyMargin

                Rectangle{
                    id: contentRect
                    width: parent.width
                    height: childrenRect.height
                    color: Style.bgColor
                    radius: Style.rectangleRadius
                    ListView {
                        id: listView
                        model: walletModel
                        interactive: false

                        width: parent.width
                        height: contentHeight
                        spacing: 0

                        delegate: Delegates.TransactionDelegate {
                            separatorVisible: index !== walletModel.count - 1
                            width: contentRect.width
                        }
                        section.property: "creationDate"
                        section.delegate: ColumnLayout {
                            width: parent.width

                            Item{
                                Layout.preferredHeight: Style.baseMargin
                                Layout.fillWidth: true
                            }

                            RowLayout {
                                Layout.fillWidth: true
                                Layout.leftMargin: Style.baseMargin
                                Layout.rightMargin: Style.baseMargin
                                Label
                                {
                                    id: dateLabel
                                    font.pixelSize: Style.fontTiny
                                    color: Style.placeholderColor
                                    text: section
                                }

                                Rectangle{
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: Style.borderWidth
                                    color: Style.placeholderColor
                                    Layout.alignment: Qt.AlignVCenter
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
