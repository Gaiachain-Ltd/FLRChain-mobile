import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Custom.Popup {
    id: popup
    title: qsTr("Success")
    iconSource: "qrc:/img/icon-success.svg"

    property string message: ""

    Label {
        Layout.fillWidth: true
        horizontalAlignment: Label.AlignHCenter
        font: Style.popupTextFont
        color: Style.popupTextFontColor
        wrapMode: Label.WordWrap
        text: popup.message
    }

    Custom.PrimaryButton {
        Layout.fillWidth: true
        backgroundColor: Style.popupSuccessColor
        borderColor: Style.popupSuccessColor
        text: qsTr("OK")

        onClicked: {
            popup.close()
        }
    }
}
