import QtQuick 2.15
import QtQuick.Controls 2.15
import com.flrchain.style 1.0

CheckBox {
    id: checkBox

    indicator: Rectangle {
        id: contentRec
        implicitWidth: Style.checkboxHeight
        implicitHeight: Style.checkboxHeight
        radius: Style.checkBoxRadius
        border.color: Style.accentColor
        border.width: Style.borderWidth

        Rectangle {
            visible: checkBox.checked
            color: Style.accentColor
            border.color: Style.accentColor
            radius: Style.checkBoxRadius
            anchors.fill: parent

            Image{
                source: "qrc:/img/checkbox-check.svg"
                height: Style.checkboxHeight
                width: Style.checkboxHeight
                anchors.centerIn: parent
                sourceSize: Qt.size(Style.checkboxHeight, Style.checkboxHeight)
            }
        }
    }

    contentItem: Text {
        anchors.verticalCenter: contentRec.verticalCenter
        text: checkBox.text
        color: Style.baseLabelColor
        verticalAlignment: Qt.AlignVCenter
        leftPadding: contentRec.width + spacing
        font.pixelSize: Style.fontTiny
        font.weight: Font.DemiBold
    }

    spacing: Style.microMargin
}
