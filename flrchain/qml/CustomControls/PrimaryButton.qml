import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls

import com.flrchain.style 1.0

Controls.Button {
    id: button
    implicitWidth: Style.defaultButtonSize.width
    implicitHeight: Style.defaultButtonSize.height

    property color backgroundColor: Style.primaryButtonBackgroundColor
    property int backgroundRadius: Style.defaultButtonRadius
    property color borderColor: Style.primaryButtonBorderColor
    property int borderWidth: Style.defaultButtonBorderWidth
    property color labelColor: Style.primaryButtonFontColor

    font: Style.buttonFont
    palette.buttonText: labelColor

    background: Rectangle {
        radius: button.backgroundRadius
        color: button.backgroundColor
        border {
            width: button.borderWidth
            color: button.borderColor
        }
    }
}
