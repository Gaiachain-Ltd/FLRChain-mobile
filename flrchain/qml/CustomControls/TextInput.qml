import QtQuick 2.15
import QtQuick.Controls 2.15
import com.flrchain.style 1.0

TextField
{
    id: textInput
    implicitWidth: parent.width
    implicitHeight: 36

    background: Rectangle {
        radius: 10
        implicitWidth: parent.width
        implicitHeight: 100
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
