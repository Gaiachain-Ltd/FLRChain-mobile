import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Custom.Popup {
    id: popup
    title: qsTr("Error")
    iconSource: "qrc:/img/icon-popup-faile.svg"

    property string errorMessage: ""

    Label {
        Layout.fillWidth: true
        horizontalAlignment: Label.AlignHCenter
        font: Style.popupTextFont
        color: Style.popupTextFontColor
        wrapMode: Label.WordWrap
        text: popup.errorMessage
    }

    Custom.PrimaryButton {
        Layout.fillWidth: true
        backgroundColor: Style.popupErrorColor
        borderColor: Style.popupErrorColor
        text: qsTr("OK")

        onClicked: {
            popup.close()
        }
    }
}
