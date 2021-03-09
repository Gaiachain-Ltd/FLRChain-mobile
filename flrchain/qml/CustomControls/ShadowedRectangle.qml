import QtQuick 2.15
import QtGraphicalEffects 1.15
import com.flrchain.style 1.0

Rectangle {
    radius: 10
    color: Style.colorTransparent

    RectangularGlow {
        anchors.fill: parent
        glowRadius: 16
        color: "#000000"
        opacity: 0.1
        cornerRadius: 10
    }
}
