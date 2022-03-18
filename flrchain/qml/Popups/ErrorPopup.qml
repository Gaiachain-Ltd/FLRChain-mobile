import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Custom.Popup {
    id: popup
    title: qsTr("Error")
    iconSrc: "qrc:/img/icon-popup-faile.svg"
    property string errorMessage: ""

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
            text: errorMessage
        }

        Custom.PrimaryButton {
            text: qsTr("OK")
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
