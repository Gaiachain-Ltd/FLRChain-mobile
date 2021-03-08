import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

TextField
{
    id: textInput
    implicitWidth: parent.width
    implicitHeight: 36

    background: Rectangle {
        radius: 10
        implicitWidth: parent.width
        implicitHeight: 100
        color: "#F7F9FB"
    }

    verticalAlignment: Qt.AlignVCenter
    horizontalAlignment: Qt.AlignLeft

    color: "#253F50"
    font.weight: Font.DemiBold
    font.pixelSize: 12
    placeholderText: textInput.placeholderText
    placeholderTextColor: "#C0C7D4"
    leftPadding: 20
}
