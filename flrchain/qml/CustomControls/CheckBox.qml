import QtQuick 2.15
import QtQuick.Controls 2.15
import com.flrchain.style 1.0

CheckBox {
    id: checkBox

    indicator: Rectangle {
        id: contentRec
        implicitWidth: 16
        implicitHeight: 16
        radius: 3
        border.color: Style.accentColor
        border.width: 1

        Rectangle {
            visible: checkBox.checked
            color: Style.accentColor
            border.color: Style.accentColor
            radius: 3
            anchors.fill: parent

            Image{
                source: ""
                height: 10
                width: 10
                anchors.centerIn: parent
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
    }

    spacing: 5
}
