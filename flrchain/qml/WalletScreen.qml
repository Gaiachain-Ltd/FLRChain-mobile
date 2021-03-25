import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom
import "qrc:/Delegates" as Delegates
import "qrc:/Popups" as Popups

Item {

    Custom.Header {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
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
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: Style.baseMargin
        contentHeight: mainColumn.height
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        ColumnLayout {
            id: mainColumn
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: Style.baseMargin
            anchors.rightMargin: Style.baseMargin

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
                value: 5.124
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
                    radius: 10
                    ListView {
                        id: listView
                        model: exampleModel
                        interactive: false

                        width: parent.width
                        height: contentHeight
                        spacing: 0

                        delegate: Delegates.TransactionDelegate {
                        }
                        //  section.property: date
                        section.delegate: RowLayout {
                            width: parent.width
                            height: dateLabel.height

                            Label
                            {
                                id: dateLabel
                                font.pixelSize: Style.fontTiny
                                color: Style.mediumLabelColor
                                text: section
                            }

                            Rectangle{
                                Layout.fillWidth: true
                                Layout.preferredHeight: 2
                                color: Style.sectionColor
                                Layout.alignment: Qt.AlignVCenter
                            }
                        }
                    }
                }
            }
        }
    }
    ListModel {
        id: exampleModel

        ListElement {
        }
        ListElement {
        }
        ListElement {
        }
    }
}
