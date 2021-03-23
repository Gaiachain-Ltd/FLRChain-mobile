import QtQuick 2.15
import QtGraphicalEffects 1.15

Image {
    id: img
    fillMode: Image.PreserveAspectCrop
    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: Item {
            width: img.width
            height: img.height
            Rectangle {
                anchors.centerIn: parent
                width: img.width
                height: img.height
                radius: 10
            }
        }
    }
}
