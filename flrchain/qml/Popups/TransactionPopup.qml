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
        spacing: Style.baseMargin

        Text {
            text: qsTr("Enter the amount you want to transfer and the phone number to which the transfer has to be made")
            Layout.fillWidth: true
            Layout.preferredHeight: 62
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
            Layout.topMargin: -Style.tinyMargin
            Layout.fillWidth: true
            Layout.preferredHeight: Style.bigInputHeight
            Custom.TextInput {
                id: amountInput
                Layout.preferredHeight: Style.bigInputHeight
                Layout.preferredWidth: 173
                placeholderText: qsTr("0")
                font.pixelSize: Style.fontUltra
                color: Style.darkLabelColor
                horizontalAlignment: Qt.AlignHCenter
                leftPadding: 0
                validator: RegExpValidator{ regExp: /^[0-9]+([.][0-9]{1,2})?$/ }
            }

            Rectangle{
                Layout.fillWidth: true
                Layout.preferredHeight: Style.bigInputHeight
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
            text: qsTr("Receiver phone")
        }

        Custom.TextInput {
            id: phoneInput
            Layout.topMargin: -Style.tinyMargin
            Layout.fillWidth: true
            placeholderText: qsTr("Phone number...")
            color: Style.darkLabelColor
            text: session.user.phone
        }

        Custom.Button {
            text: qsTr("Cash out")
            Layout.fillWidth: true
            enabled: phoneInput.displayText.length > 0 && amountInput.displayText.length > 0
            opacity: enabled ? 1.0 : 0.5

            onClicked: {
                console.log(amountInput.text, phoneInput.text);
                session.cashOut(amountInput.text, phoneInput.text);
                popup.close();
            }
        }

        Custom.Button {
            text: qsTr("Cancel")
            Layout.bottomMargin: Style.tinyMargin
            Layout.fillWidth: true
            bgColor: Style.buttonSecColor

            onClicked: {
                popup.close()
            }
        }
    }
}
