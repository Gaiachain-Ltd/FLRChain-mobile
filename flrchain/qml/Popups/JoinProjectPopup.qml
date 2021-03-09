import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Custom.Popup {
    title: qsTr("Send request")

    ColumnLayout {
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true
        Layout.leftMargin: Style.baseMargin
        Layout.rightMargin: Style.baseMargin
        spacing: 20

        Label {
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: Style.fontSmall
            font.weight: Font.DemiBold
            color: Style.darkLabelColor
            text: qsTr("Are you sure you want to join to the project")
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: -15
            font.pointSize: Style.fontSmall
            color: Style.accentColor
            text: qsTr("Eum Repellendus Aut")
        }

        Custom.Button {
            id: registerButton
            text: qsTr("Send request")

            onClicked: {
            }
        }

        Custom.Button {
            id: loginButton
            text: qsTr("Cancel")
            Layout.bottomMargin: Style.smallMargin
            bgColor: Style.buttonSecColor

            onClicked: {
            }
        }
    }
}
