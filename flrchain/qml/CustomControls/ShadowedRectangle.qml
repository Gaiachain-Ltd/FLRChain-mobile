import QtQuick 2.15
import QtGraphicalEffects 1.15

Rectangle {
    radius: 10
    color: "#00000014"

    RectangularGlow {
        anchors.fill: parent
        glowRadius: 16
        color: "#000000"
        opacity: 0.1
        cornerRadius: 10
    }
}

