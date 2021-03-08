import QtQuick 2.15
import QtQuick.Controls 2.15

Button
{
    id: control

    property int radius: 0
    property string iconSrc: ""
    property int iconSize: 15
    property int iconContainerSize: iconSize

    width: 15
    height: 15

    background: Rectangle
    {
        width: control.width
        height: control.height

        color: "#00ffffff"
        border.color: "#00ffffff"

        radius: control.radius
    }

    contentItem: Item
    {
        anchors.fill: parent

        Item
        {
            width: control.iconContainerSize
            height: width
            anchors.verticalCenter: parent.verticalCenter
            Image
            {
                id: imageIcon
                anchors.centerIn: parent

                source: control.iconSrc
                asynchronous: true

                opacity: control.enabled ? 1.0 : 0.3

                width: control.iconSize
                height: control.iconSize

                fillMode: Image.PreserveAspectFit
            }
        }
    }
}
