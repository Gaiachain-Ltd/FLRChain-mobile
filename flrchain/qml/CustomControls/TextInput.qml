import QtQuick 2.15
import QtQuick.Controls 2.15

import com.flrchain.style 1.0

TextField {
    id: textInput
    implicitWidth: Style.defaultTextInputSize.width
    implicitHeight: Style.defaultTextInputSize.height

    property bool isValid: true

    background: Rectangle {
        radius: Style.baseRadius
        color: textInput.isValid ? Style.textInputValidBackgroundColor
                                 : Style.textInputInvalidBackgroundColor
    }

    verticalAlignment: Qt.AlignVCenter
    horizontalAlignment: Qt.AlignLeft
    leftPadding: Style.textInputPadding
    rightPadding: Style.textInputPadding
    font: Style.textInputFont
    color: isValid ? Style.textInputValidFontColor
                   : Style.textInputInvalidFontColor
    placeholderText: textInput.placeholderText
    placeholderTextColor: isValid ? Style.textInputPlaceholderFontColor
                                  : Style.textInputInvalidFontColor
}
