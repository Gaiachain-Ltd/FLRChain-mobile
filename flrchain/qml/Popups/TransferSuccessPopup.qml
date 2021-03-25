import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Custom.Popup {
    id: popup
    title: qsTr("Transfer has been made")

    ColumnLayout {
        Layout.fillWidth: true
        Layout.leftMargin: Style.baseMargin
        Layout.rightMargin: Style.baseMargin
        spacing: Style.baseMargin

        Row {
            Layout.alignment: Qt.AlignHCenter

            Label {
                Layout.alignment: Qt.AlignHCenter
                font.pointSize: Style.fontSmall
                font.weight: Font.DemiBold
                color: Style.darkLabelColor
                text: qsTr("You transferred ")
            }

            Label {
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: -Style.smallMargin
                font.pointSize: Style.fontSmall
                color: Style.accentColor
                font.weight: Font.Bold
                text: qsTr("452 USDC")
            }
        }

        Row {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: -Style.baseMargin
            Label {
                Layout.alignment: Qt.AlignHCenter
                font.pointSize: Style.fontSmall
                font.weight: Font.DemiBold
                color: Style.darkLabelColor
                text: qsTr("to the phone number: ")
            }

            Label {
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: -Style.smallMargin
                font.pointSize: Style.fontSmall
                color: Style.accentColor
                font.weight: Font.Bold
                text: qsTr("+00 111 222 111")
            }
        }

        Custom.Button {
            text: qsTr("Back to wallet")
            Layout.fillWidth: true

            onClicked: {
                popup.close()
            }
        }

        Item{
            Layout.fillWidth: true
        }
    }
}
