import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

CheckBox {
    id: checkBox

    indicator: Rectangle {
        id: contentRec
        implicitWidth: 16
        implicitHeight: 16
        radius: 3
        border.color: "#23BC3D"
        border.width: 1

        Rectangle {
            visible: checkBox.checked
            color: "#23BC3D"
            border.color: "#23BC3D"
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
        color: "#778699"
        verticalAlignment: Qt.AlignVCenter
        leftPadding: contentRec.width + spacing
        font.pixelSize: 12
    }

    spacing: 5
}
