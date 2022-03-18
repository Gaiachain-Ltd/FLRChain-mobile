import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import com.flrchain.style 1.0

Controls.Button {
    id: button

    property string bgColor: Style.accentColor

    implicitHeight: Style.buttonHeight
    implicitWidth: parent.width

    background: Rectangle {
        radius: Style.baseRadius
        color: bgColor
    }

    contentItem: Text {
        text: button.text
        font.pixelSize: Style.fontMedium
        color: Style.bgColor
        font.weight: Font.DemiBold
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
