import QtQuick 2.15
import QtQuick.Controls 2.15
import com.flrchain.style 1.0

TextField
{
    id: textInput
    implicitWidth: parent.width
    implicitHeight: Style.textInputHeight

    background: Rectangle {
        id: bg
        radius: Style.baseRadius
        implicitWidth: parent.width
        implicitHeight: parent.height
        color: Style.inputBgColor
    }

    verticalAlignment: Qt.AlignVCenter
    horizontalAlignment: Qt.AlignLeft

    color: Style.darkLabelColor
    font.weight: Font.DemiBold
    font.pixelSize: Style.fontTiny
    placeholderText: textInput.placeholderText
    placeholderTextColor: Style.placeholderColor
    leftPadding: Style.baseMargin
}
