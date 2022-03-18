import QtQuick 2.15
import QtQuick.Controls 2.15
import com.flrchain.style 1.0

Button {
    id: control

    property int radius: 0
    property string iconSrc: ""
    property size iconSize: Qt.size(Style.iconSize, Style.iconSize)
    property size iconContainerSize: iconSize

    implicitWidth: Style.iconButtonHeight
    implicitHeight: Style.iconButtonHeight

    background: null

    contentItem: Item {
        anchors.fill: parent

        Item {
            width: control.iconContainerSize.width
            height: control.iconContainerSize.height
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: imageIcon
                anchors.centerIn: parent

                source: control.iconSrc
                asynchronous: true

                opacity: control.enabled ? 1.0 : 0.3

                width: control.iconSize.width
                height: control.iconSize.height

                fillMode: Image.PreserveAspectFit
                sourceSize: Qt.size(width, height)
            }
        }
    }
}
