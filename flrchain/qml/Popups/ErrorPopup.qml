import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.flrchain.style 1.0

import "qrc:/CustomControls" as Custom

Custom.Popup {
    id: popup
    title: qsTr("Error")
    property string errorMessage: ""
    iconSrc: "qrc:/img/icon-popup-faile.svg"

    ColumnLayout {
        Layout.fillWidth: true
        Layout.leftMargin: Style.baseMargin
        Layout.rightMargin: Style.baseMargin
        spacing: 20

        Label {
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: Style.fontSmall
            font.weight: Font.DemiBold
            color: Style.darkLabelColor
            text: errorMessage
        }

        Custom.Button {
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
