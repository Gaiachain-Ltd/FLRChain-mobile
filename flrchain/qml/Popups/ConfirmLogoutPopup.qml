import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Custom.Popup {
    id: popup
    title: qsTr("Confirm Logout")
    iconSource: "qrc:/img/icon-confirmation.svg"

    Label {
        Layout.alignment: Qt.AlignHCenter
        font: Style.popupTextFont
        color: Style.popupTextFontColor
        text: qsTr("Are you sure you want to log out?")
    }

    Custom.SecondaryButton {
        Layout.fillWidth: true
        text: qsTr("Cancel")

        onClicked: {
            popup.close()
        }
    }

    Custom.PrimaryButton {
        Layout.fillWidth: true
        text: qsTr("Log out")

        onClicked: {
            popup.close()
            session.logout()
        }
    }
}
