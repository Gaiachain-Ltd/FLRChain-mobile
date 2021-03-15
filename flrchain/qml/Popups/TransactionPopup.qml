import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Custom.Popup {
    id: popup
    title: qsTr("Transaction")
    iconSrc: "qrc:/img/icon-transaction.svg"

    ColumnLayout {
        Layout.fillWidth: true
        Layout.leftMargin: Style.baseMargin
        Layout.rightMargin: Style.baseMargin
        spacing: 20

        Text {
            text: qsTr("Enter the amount you want to transfer and the phone number to which the transfer is to be made")
            Layout.fillWidth: true
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            color: Style.darkLabelColor
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            font.pointSize: Style.fontTiny
            font.weight: Font.DemiBold
            color: Style.mediumLabelColor
            text: qsTr("Amount")
        }

        RowLayout{
            Layout.topMargin: -Style.smallMargin
            Layout.fillWidth: true
            Layout.preferredHeight: 56
            Custom.TextInput {
                id: amountInput
                Layout.preferredHeight: 56
                Layout.preferredWidth: 173
                placeholderText: qsTr("0")
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
                horizontalAlignment: Qt.AlignHCenter
                leftPadding: 0
            }

            Rectangle{
                Layout.fillWidth: true
                Layout.preferredHeight: 56
                Label {
                    anchors.centerIn: parent
                    font.pointSize: Style.fontUltra
                    font.weight: Font.DemiBold
                    color: Style.darkLabelColor
                    text: qsTr("USDC")
                }
            }
        }

        Label {
            font.pointSize: Style.fontTiny
            font.weight: Font.DemiBold
            color: Style.mediumLabelColor
            text: qsTr("Receiver email")
        }

        Custom.TextInput {
            Layout.topMargin: -Style.smallMargin
            Layout.fillWidth: true
            placeholderText: qsTr("+00 111 222 111")
            color: Style.darkLabelColor
        }

        Custom.Button {
            text: qsTr("Cash out")
            Layout.fillWidth: true

            onClicked: {
            }
        }

        Custom.Button {
            text: qsTr("Cancel")
            Layout.bottomMargin: Style.smallMargin
            Layout.fillWidth: true
            bgColor: Style.buttonSecColor

            onClicked: {
                popup.close()
            }
        }
    }
}
