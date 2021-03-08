import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: button

    property string bgColor: "#23BC3D"

    implicitHeight: 42
    implicitWidth: parent.width

    background: Rectangle {
        anchors.fill: parent
        radius: 10
        color: bgColor
    }

    contentItem: Text {
        text: button.text
        font.pixelSize: 15
        color: "#FFFFFF"
        font.weight: Font.DemiBold
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
