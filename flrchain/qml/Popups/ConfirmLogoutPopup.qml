import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Custom.Popup {
    id: popup
    title: qsTr("Confirm Logout")
    iconSrc: "qrc:/img/icon-confirmation.svg"

    ColumnLayout {
        Layout.fillWidth: true
        Layout.leftMargin: Style.baseMargin
        Layout.rightMargin: Style.baseMargin
        spacing: Style.baseMargin

        Label {
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: Style.fontSmall
            font.weight: Font.DemiBold
            color: Style.darkLabelColor
            text: qsTr("Are you sure you want to log out?")
        }

        Custom.Button {
            text: qsTr("Log out")
            Layout.fillWidth: true

            onClicked: {
                popup.close()
                session.logout()
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
