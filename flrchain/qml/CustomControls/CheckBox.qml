import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls

import com.flrchain.style 1.0

Controls.CheckBox {
    id: checkBox
    padding: 0
    spacing: Style.checkboxSpacing

    background: null

    indicator: Rectangle {
        implicitWidth: Style.checkboxSize.width
        implicitHeight: Style.checkboxSize.height
        radius: Style.checkboxBorderRadius
        border {
            width: Style.checkboxBorderWidth
            color: Style.checkboxBorderColor
        }

        Image {
            anchors.centerIn: parent
            sourceSize: Style.checkboxTickSize
            source: "qrc:/img/checkbox-check.svg"
            visible: checkBox.checked
        }
    }

    contentItem: Controls.Label {
        anchors.verticalCenter: indicator.verticalCenter
        verticalAlignment: Qt.AlignVCenter
        leftPadding: indicator.width + spacing
        font: Style.checkboxLabelFont
        color: Style.checkBoxLabelFontColor
        text: checkBox.text
    }
}
