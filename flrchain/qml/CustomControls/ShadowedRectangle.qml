import QtQuick 2.15
import QtGraphicalEffects 1.15
import com.flrchain.style 1.0

Rectangle {
    id: root
    radius: Style.rectangleRadius
    color: Style.colorTransparent

    property int shadowHorizontalOffset: 5
    property int shadowVerticalOffset: 15
    property int shadowRadius: 30
    property color shadowColor: "#29000000"

    layer.enabled: true
    layer.effect: DropShadow {
        horizontalOffset: root.shadowHorizontalOffset
        verticalOffset: root.shadowVerticalOffset
        radius: root.shadowRadius
        color: root.shadowColor
    }
}
